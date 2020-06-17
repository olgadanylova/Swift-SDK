//
//  PersistenceServiceUtilsLocal.swift
//
/*
 * *********************************************************************************************************************
 *
 *  BACKENDLESS.COM CONFIDENTIAL
 *
 *  ********************************************************************************************************************
 *
 *  Copyright 2020 BACKENDLESS.COM. All Rights Reserved.
 *
 *  NOTICE: All information contained herein is, and remains the property of Backendless.com and its suppliers,
 *  if any. The intellectual and technical concepts contained herein are proprietary to Backendless.com and its
 *  suppliers and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret
 *  or copyright law. Dissemination of this information or reproduction of this material is strictly forbidden
 *  unless prior written permission is obtained from Backendless.com.
 *
 *  ********************************************************************************************************************
 */

class PersistenceServiceUtilsLocal {
    
    static let shared = PersistenceServiceUtilsLocal()
    
    private init() { }
    
    func initLocalDatabase(tableName: String, whereClause: String?, responseHandler: (() -> Void)!, errorHandler: ((Fault) -> Void)!) {
        LocalManager.shared.createTableIfNotExist(tableName)
        let recordsCount = LocalManager.shared.getNumberOfRecords(tableName, whereClause: whereClause)
        if recordsCount is Fault {
            errorHandler(recordsCount as! Fault)
        }
        if recordsCount is Int, recordsCount as! Int > 0 {
            errorHandler(Fault(message: "Table '\(tableName)' already has records"))
        }
        else {
            let queryBuilder = DataQueryBuilder()
            queryBuilder.whereClause = whereClause
            queryBuilder.pageSize = 100
            PersistenceServiceUtils(tableName: tableName).find(queryBuilder: queryBuilder, responseHandler: { foundObjects in
                if foundObjects.count > 0 {
                    for object in foundObjects {
                        LocalManager.shared.initInsert(tableName: tableName, object: object, errorHandler: errorHandler)
                    }
                    queryBuilder.prepareNextPage()
                    self.nextPage(tableName: tableName, queryBuilder: queryBuilder, responseHandler: responseHandler, errorHandler: errorHandler)
                }
            }, errorHandler: { fault in
                errorHandler(fault)
            })
        }
    }
    
    private func nextPage(tableName: String, queryBuilder: DataQueryBuilder, responseHandler: (() -> Void)!, errorHandler: ((Fault) -> Void)!) {
        PersistenceServiceUtils(tableName: tableName).find(queryBuilder: queryBuilder, responseHandler: { foundObjects in
            for object in foundObjects {
                LocalManager.shared.initInsert(tableName: tableName, object: object, errorHandler: errorHandler)
            }
            if foundObjects.count == 0 {
                responseHandler()
                return
            }
            queryBuilder.prepareNextPage()            
            self.nextPage(tableName: tableName, queryBuilder: queryBuilder, responseHandler: responseHandler, errorHandler: errorHandler)
        }, errorHandler: { fault in
            errorHandler(fault)
        })
    }
    
    // MARK: - Internal functions
    
    func clearLocalDatabase(_ tableName: String) {
        if LocalManager.shared.tableExists(tableName) {
            LocalManager.shared.dropTable(tableName)
            OfflineSyncManager.shared.uow.operations.removeAll(where: { $0.tableName == tableName })
            UOWHelper.shared.saveUOW(OfflineSyncManager.shared.uow)
        }
    }
    
    func saveEventually(tableName: String, entity: [String : Any], callback: OfflineAwareCallback?) {
        if ConnectionManager.isConnectedToNetwork() {
            saveEventuallyWhenOnline(tableName: tableName, entity: entity, callback: callback)
        }
        else {
            saveEventuallyWhenOffline(tableName: tableName, entity: entity, callback: callback)
        }
    }
    
    func removeEventually(tableName: String, entity: [String : Any], callback: OfflineAwareCallback?) {
        if ConnectionManager.isConnectedToNetwork() {
            removeEventuallyWhenOnline(tableName: tableName, entity: entity, callback: callback)
        }
        else {
            removeEventuallyWhenOffline(tableName: tableName, entity: entity, callback: callback)
        }
    }
    
    // MARK: - Private functions
    
    private func saveEventuallyWhenOnline(tableName: String, entity: [String : Any], callback: OfflineAwareCallback?) {
        let semaphore = DispatchSemaphore(value: 0)
        let objectId = entity["objectId"] as? String
        let blLocalId = entity["blLocalId"] as? NSNumber
        let wrappedResponseHandler = self.wrapLocalHandlerWhenOnline(callback?.localResponseHandler, callback: callback)
        let persistenceServiceUtils = PersistenceServiceUtils(tableName: tableName)
        
        // create remotely - create locally
        if objectId == nil, blLocalId == nil {
            DispatchQueue.global().async {
                persistenceServiceUtils.create(entity: PersistenceLocalHelper.shared.removeAllLocalFields(entity), responseHandler: { responseObject in
                    callback?.remoteResponseHandler?(responseObject)
                    LocalManager.shared.insert(tableName: tableName, object: responseObject, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                    semaphore.signal()
                }, errorHandler: { fault in
                    callback?.remoteErrorHandler?(fault)
                    semaphore.signal()
                })
            }
        }
            // if record exists locally and objectId != nil: update remotely - update locally
            // if record exists locally and objectId == nil: create remotely - update locally
            // if record doesn't exist locally: create remotely - create locally
        else if objectId == nil, blLocalId != nil {
            let whereClause = "blLocalId=\(blLocalId!)"
            let localResult = LocalManager.shared.select(tableName: tableName, whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
                semaphore.signal()
            }
            else if let localObjects = localResult as? [[String : Any]] {
                if let localObject = localObjects.first {
                    if let objId = localObject["objectId"] as? String {
                        var objectToUpdate = entity
                        objectToUpdate["objectId"] = objId
                        DispatchQueue.global().async {
                            persistenceServiceUtils.update(entity: PersistenceLocalHelper.shared.removeAllLocalFields(objectToUpdate), responseHandler: { responseObject in
                                callback?.remoteResponseHandler?(responseObject)
                                LocalManager.shared.update(tableName: tableName, newValues: responseObject, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                                semaphore.signal()
                            }, errorHandler: { fault in
                                callback?.remoteErrorHandler?(fault)
                                semaphore.signal()
                            })
                        }
                    }
                    else {
                        DispatchQueue.global().async {
                            persistenceServiceUtils.create(entity: PersistenceLocalHelper.shared.removeAllLocalFields(entity), responseHandler: { responseObject in
                                callback?.remoteResponseHandler?(responseObject)
                                LocalManager.shared.update(tableName: tableName, newValues: responseObject, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                                semaphore.signal()
                            }, errorHandler: { fault in
                                callback?.remoteErrorHandler?(fault)
                                semaphore.signal()
                            })
                        }
                    }
                }
                else {
                    DispatchQueue.global().async {
                        persistenceServiceUtils.create(entity: PersistenceLocalHelper.shared.removeAllLocalFields(entity), responseHandler: { responseObject in
                            callback?.remoteResponseHandler?(responseObject)
                            LocalManager.shared.insert(tableName: tableName, object: responseObject, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                            semaphore.signal()
                        }, errorHandler: { fault in
                            callback?.remoteErrorHandler?(fault)
                            semaphore.signal()
                        })
                    }
                }
            }
        }
            // update remotely
            // if record exists locally: update locally
            // if record doesn't exist locally: create locally
        else if objectId != nil, blLocalId == nil {
            DispatchQueue.global().async {
                persistenceServiceUtils.update(entity: PersistenceLocalHelper.shared.removeAllLocalFields(entity), responseHandler: { responseObject in
                    callback?.remoteResponseHandler?(responseObject)
                    let whereClause = "objectId='\(objectId!)'"
                    let localResult = LocalManager.shared.select(tableName: tableName, whereClause: whereClause)
                    if let fault = localResult as? Fault {
                        callback?.localErrorHandler?(fault)
                        semaphore.signal()
                    }
                    else if let localObjects = localResult as? [[String : Any]] {
                        if localObjects.first != nil {
                            LocalManager.shared.update(tableName: tableName, newValues: responseObject, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                            semaphore.signal()
                        }
                        else {
                            LocalManager.shared.insert(tableName: tableName, object: responseObject, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                            semaphore.signal()
                        }
                    }
                }, errorHandler: { fault in
                    callback?.remoteErrorHandler?(fault)
                    semaphore.signal()
                })
            }
        }
            // update remotely
            // if record exists locally: update locally
            // if record doesn't exist locally: create locally
        else if objectId != nil, blLocalId != nil {
            DispatchQueue.global().async {
                persistenceServiceUtils.update(entity: PersistenceLocalHelper.shared.removeAllLocalFields(entity), responseHandler: { responseObject in
                    callback?.remoteResponseHandler?(responseObject)
                    let whereClause = "blLocalId=\(blLocalId!)"
                    let localResult = LocalManager.shared.select(tableName: tableName, whereClause: whereClause)
                    if let fault = localResult as? Fault {
                        callback?.localErrorHandler?(fault)
                        semaphore.signal()
                    }
                    else if let localObjects = localResult as? [[String : Any]],
                        let _ = localObjects.first {
                        LocalManager.shared.update(tableName: tableName, newValues: responseObject, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                        semaphore.signal()
                    }
                }, errorHandler: { fault in
                    callback?.remoteErrorHandler?(fault)
                    semaphore.signal()
                })
            }
        }
        semaphore.wait()
        return
    }
    
    private func saveEventuallyWhenOffline(tableName: String, entity: [String : Any], callback: OfflineAwareCallback?) {        
        let objectId = entity["objectId"] as? String
        let blLocalId = entity["blLocalId"] as? NSNumber
        let wrappedResponseHandler = self.wrapLocalHandlerWhenOffline(tableName: tableName, localResponseHandler: callback?.localResponseHandler, callback: callback)
        // save locally
        if objectId == nil, blLocalId == nil {
            LocalManager.shared.insert(tableName: tableName, object: entity, blPendingOperation: .create, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
        }
            // if record exists locally: update locally
            // if record doesn't exist locally: create locally
        else if objectId == nil, blLocalId != nil {
            let whereClause = "blLocalId=\(blLocalId!)"
            let localResult = LocalManager.shared.select(tableName: tableName, whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
            }
            else if let localObjects = localResult as? [[String : Any]] {
                if localObjects.first != nil {
                    LocalManager.shared.update(tableName: tableName, newValues: entity, whereClause: whereClause, blPendingOperation: .update, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
                else {
                    LocalManager.shared.insert(tableName: tableName, object: entity, blPendingOperation: .create, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
            }
        }
            // if record exists locally: update locally
            // if record doesn't exist locally: create locally
        else if objectId != nil, blLocalId == nil {
            let whereClause = "objectId='\(objectId!)'"
            let localResult = LocalManager.shared.select(tableName: tableName, whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
            }
            else if let localObjects = localResult as? [[String : Any]] {
                if localObjects.first != nil {
                    LocalManager.shared.update(tableName: tableName, newValues: entity, whereClause: whereClause, blPendingOperation: .update, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
                else {
                    LocalManager.shared.insert(tableName: tableName, object: entity, blPendingOperation: .create, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
            }
        }
        else if objectId != nil, blLocalId != nil {
            let whereClause = "objectId='\(objectId!)' AND blLocalId=\(blLocalId!)"
            let localResult = LocalManager.shared.select(tableName: tableName, whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
            }
            else if let localObjects = localResult as? [[String : Any]],
                localObjects.first != nil {
                LocalManager.shared.update(tableName: tableName, newValues: entity, whereClause: whereClause, blPendingOperation: .update, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
            }
        }
    }
    
    private func removeEventuallyWhenOnline(tableName: String, entity: [String : Any], callback: OfflineAwareCallback?) {
        let semaphore = DispatchSemaphore(value: 0)
        let objectId = entity["objectId"] as? String
        let blLocalId = entity["blLocalId"] as? NSNumber
        let wrappedResponseHandler = self.wrapLocalHandlerWhenOnline(callback?.localResponseHandler, callback: callback)
        
        // if record exists locally and objectId != nil: remove remotely - remove locally
        // if record exists locally and objectId == nil: remove locally
        if objectId == nil, blLocalId != nil {
            let whereClause = "blLocalId=\(blLocalId!)"
            let localResult = LocalManager.shared.select(tableName: tableName, whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
                semaphore.signal()
            }
            else if let localObjects = localResult as? [[String : Any]],
                let localObject = localObjects.first {
                if let objId = localObject["objectId"] as? String {
                    DispatchQueue.global().async {
                        PersistenceServiceUtils(tableName: tableName).removeById(objectId: objId, responseHandler: { response in
                            callback?.remoteResponseHandler?(response)
                            LocalManager.shared.delete(tableName: tableName,whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                            semaphore.signal()
                        }, errorHandler: { fault in
                            callback?.remoteErrorHandler?(fault)
                            semaphore.signal()
                        })
                    }
                }
                else {
                    LocalManager.shared.delete(tableName: tableName, whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                    semaphore.signal()
                }
            }
        }
            
            // remove remotely
            // if record exists locally: remove locally
        else if objectId != nil, blLocalId == nil {
            DispatchQueue.global().async {
                PersistenceServiceUtils(tableName: tableName).removeById(objectId: objectId!, responseHandler: { response in
                    callback?.remoteResponseHandler?(response)
                    let whereClause = "objectId='\(objectId!)'"
                    let localResult = LocalManager.shared.select(tableName: tableName, whereClause: whereClause)
                    if let fault = localResult as? Fault {
                        callback?.localErrorHandler?(fault)
                        semaphore.signal()
                    }
                    else if localResult is [[String : Any]] {
                        LocalManager.shared.delete(tableName: tableName, whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                        semaphore.signal()
                    }
                }, errorHandler: { fault in
                    callback?.remoteErrorHandler?(fault)
                    semaphore.signal()
                })
            }
        }
        else if objectId != nil, blLocalId != nil {
            DispatchQueue.global().async {
                PersistenceServiceUtils(tableName: tableName).removeById(objectId: objectId!, responseHandler: { response in
                    callback?.remoteResponseHandler?(response)
                    let whereClause = "objectId='\(objectId!)' AND blLocalId=\(blLocalId!)"
                    let localResult = LocalManager.shared.select(tableName: tableName, whereClause: whereClause)
                    if let fault = localResult as? Fault {
                        callback?.localErrorHandler?(fault)
                        semaphore.signal()
                    }
                    else if localResult is [[String : Any]] {
                        LocalManager.shared.delete(tableName: tableName, whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                        semaphore.signal()
                    }
                }, errorHandler: { fault in
                    callback?.remoteErrorHandler?(fault)
                    semaphore.signal()
                })
            }
        }
        semaphore.wait()
        return
    }
    
    private func removeEventuallyWhenOffline(tableName: String, entity: [String : Any], callback: OfflineAwareCallback?) {
        let objectId = entity["objectId"] as? String
        let blLocalId = entity["blLocalId"] as? NSNumber
        let wrappedResponseHandler = wrapLocalHandlerWhenOffline(tableName: tableName, localResponseHandler: callback?.localResponseHandler, callback: callback)
        
        // if record exists locally: remove locally
        if objectId == nil, blLocalId != nil {
            let whereClause = "blLocalId=\(blLocalId!)"
            LocalManager.shared.delete(tableName: tableName, whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
        }
            // if record exists locally: update with BlPendingOperation = .delete
        else if objectId != nil, blLocalId == nil {
            let whereClause = "objectId='\(objectId!)'"
            let localResult = LocalManager.shared.select(tableName: tableName, whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
            }
            else if let localObjects = localResult as? [[String : Any]],
                localObjects.first != nil {
                LocalManager.shared.update(tableName: tableName, newValues: entity, whereClause: whereClause, blPendingOperation: .delete, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
            }
        }
            // if record exists locally: update with BlPendingOperation = .delete
        else if objectId != nil, blLocalId != nil {
            let whereClause = "objectId='\(objectId!)' AND blLocalId=\(blLocalId!)"
            let localResult = LocalManager.shared.select(tableName: tableName, whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
            }
            else if let localObjects = localResult as? [[String : Any]],
                localObjects.first != nil {
                LocalManager.shared.update(tableName: tableName, newValues: entity, whereClause: whereClause, blPendingOperation: .delete, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
            }
        }
    }
    
    private func wrapLocalHandlerWhenOnline(_ localResponseHandler: ((Any) -> Void)?, callback: OfflineAwareCallback?) -> ((Any) -> Void) {
        let wrappedHandler: (Any) -> () = { response in
            if let responseDict = response as? [String : Any] {
                localResponseHandler?(PersistenceLocalHelper.shared.removeLocalTimestampAndPendingOpFields(responseDict))
            }
        }
        return wrappedHandler
    }
    
    private func wrapLocalHandlerWhenOffline(tableName: String, localResponseHandler: ((Any) -> Void)?, callback: OfflineAwareCallback?) -> ((Any) -> Void) {
        let wrappedHandler: (Any) -> () = { response in
            
            print("HERE1")
            
            if var responseDictForOffline = response as? [String : Any] {         
                if !ConnectionManager.isConnectedToNetwork() {
                    if let blPendingOperation = responseDictForOffline["blPendingOperation"] as? NSNumber,
                        let blLocalId = responseDictForOffline["blLocalId"] as? NSNumber {
                        var operations = OfflineSyncManager.shared.uow.operations
                        if blPendingOperation == 0 {
                            let createResult = OfflineSyncManager.shared.uow.create(tableName: tableName, objectToSave: responseDictForOffline)
                            createResult.opResultId = "create\(tableName)\(blLocalId)"                    
                            OfflineSyncManager.shared.offlineAwareCallbacks[createResult.opResultId!] = callback
                            OfflineSyncManager.shared.opResultIdToBlLocalId[createResult.opResultId!] = blLocalId
                        }
                        else if blPendingOperation == 1 {
                            if operations.count > 0 {
                                for i in 0..<operations.count {
                                    let operation = operations[i]
                                    if operation.tableName == tableName,
                                        var payload = operation.payload as? [String : Any],
                                        payload["blLocalId"] as? NSNumber == blLocalId {
                                        if payload["objectId"] == nil {
                                            responseDictForOffline["blPendingOperation"] = 0
                                            operation.payload = responseDictForOffline
                                            operation.operationType = .CREATE
                                            operations[i] = operation
                                        }
                                        else {
                                            for (key, value) in responseDictForOffline {
                                                payload[key] = value
                                            }
                                            operation.payload = payload
                                            operation.operationType = .UPDATE
                                            operations[i] = operation
                                        }
                                    }
                                    else {
                                        let updateResult = OfflineSyncManager.shared.uow.update(tableName: tableName, objectToSave: responseDictForOffline)
                                        updateResult.opResultId = "update\(tableName)\(blLocalId)"
                                        OfflineSyncManager.shared.offlineAwareCallbacks[updateResult.opResultId!] = callback
                                        OfflineSyncManager.shared.opResultIdToBlLocalId[updateResult.opResultId!] = blLocalId
                                    }
                                }
                                OfflineSyncManager.shared.uow.operations = operations
                            }
                            else {
                                let updateResult = OfflineSyncManager.shared.uow.update(tableName: tableName, objectToSave: responseDictForOffline)
                                updateResult.opResultId = "update\(tableName)\(blLocalId)"
                                OfflineSyncManager.shared.offlineAwareCallbacks[updateResult.opResultId!] = callback
                                OfflineSyncManager.shared.opResultIdToBlLocalId[updateResult.opResultId!] = blLocalId
                            }
                        }
                        else if blPendingOperation == 2 {
                            print("HERE 2")
                            if operations.count > 0 {
                                print("1")
                                var operationsToRemove = [Int]()
                                for i in 0..<operations.count {
                                    let operation = operations[i]
                                    if operation.tableName == tableName,
                                        let payload = operation.payload as? [String : Any],
                                        payload["blLocalId"] as? NSNumber == blLocalId {
                                        print("1.1")
                                        if payload["objectId"] == nil {
                                            print("1.2")
                                            operationsToRemove.append(i)
                                        }
                                        else if let objectId = payload["objectId"] as? String {
                                            print("1.3")
                                            let deleteResult = OfflineSyncManager.shared.uow.delete(tableName: tableName, objectId: objectId)
                                            deleteResult.opResultId = "delete\(tableName)\(blLocalId)"
                                            OfflineSyncManager.shared.offlineAwareCallbacks[deleteResult.opResultId!] = callback
                                            OfflineSyncManager.shared.opResultIdToBlLocalId[deleteResult.opResultId!] = blLocalId
                                        }
                                    }
                                    else if let payload = operation.payload as? [String : Any],
                                        let objectId = payload["objectId"] as? String {
                                        print("2")
                                        let deleteResult = OfflineSyncManager.shared.uow.delete(tableName: tableName, objectId: objectId)
                                        deleteResult.opResultId = "delete\(tableName)\(blLocalId)"
                                        OfflineSyncManager.shared.offlineAwareCallbacks[deleteResult.opResultId!] = callback
                                        OfflineSyncManager.shared.opResultIdToBlLocalId[deleteResult.opResultId!] = blLocalId
                                    }
                                }
                                
                                // operations remove at operationsToRemove
                                OfflineSyncManager.shared.uow.operations = operations
                                    .enumerated()
                                    .filter { !operationsToRemove.contains($0.offset) }
                                    .map { $0.element }
                            }
                            else if let objectId = responseDictForOffline["objectId"] as? String {
                                print("3")
                                let deleteResult = OfflineSyncManager.shared.uow.delete(tableName: tableName, objectId: objectId)
                                deleteResult.opResultId = "delete\(tableName)\(blLocalId)"
                                OfflineSyncManager.shared.offlineAwareCallbacks[deleteResult.opResultId!] = callback
                                OfflineSyncManager.shared.opResultIdToBlLocalId[deleteResult.opResultId!] = blLocalId
                            }
                        }
                    }                    
                    UOWHelper.shared.saveUOW(OfflineSyncManager.shared.uow)
                }
                let responseDict = PersistenceLocalHelper.shared.prepareOfflineObjectForResponse(responseDictForOffline)
                localResponseHandler?(PersistenceLocalHelper.shared.removeLocalTimestampAndPendingOpFields(responseDict))
            }
        }
        return wrappedHandler
    }
    
    private func generateWhereClause(objectId: String?, blLocalId: NSNumber?) -> String {
        var whereClause = ""
        if objectId == nil, blLocalId != nil {
            whereClause = "blLocalId=\(blLocalId!)"
        }
        else if objectId != nil, blLocalId == nil {
            whereClause = "objectId=\(objectId!)"
        }
        else if objectId != nil, blLocalId != nil {
            whereClause = "objectId=\(objectId!) AND blLocalId=\(blLocalId!)"
        }
        return whereClause
    }
}
