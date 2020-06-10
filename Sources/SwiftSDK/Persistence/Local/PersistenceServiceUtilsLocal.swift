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
    
    func removeEventually(entity: [String : Any], callback: OfflineAwareCallback?) {
        if ConnectionManager.isConnectedToNetwork() {
            // removeEventuallyWhenOnline(entity, callback: callback)
        }
        else {
            // removeEventuallyWhenOffline(entity, callback: callback)
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
                        let localObject = localObjects.first {
                        LocalManager.shared.update(tableName: tableName, newValues: localObject, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
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
            if let responseDictForOffline = response as? [String : Any] {
                if !ConnectionManager.isConnectedToNetwork() {
                    if let blPendingOperation = responseDictForOffline["blPendingOperation"] as? NSNumber,
                        let blLocalId = responseDictForOffline["blLocalId"] as? NSNumber {
                        if blPendingOperation == 0 {
                            // remove blLocalId, blLocalTimestamp, blPendingOperation
                            // OfflineSyncManager.shared.uow.create
                            let createResult = OfflineSyncManager.shared.uow.create(tableName: tableName, objectToSave: PersistenceLocalHelper.shared.removeAllLocalFields(responseDictForOffline))
                            createResult.opResultId = "create\(tableName)\(blLocalId)"
                            
                            print("***** ⚠️Sync operations: *****")
                            for operation in OfflineSyncManager.shared.uow.operations {
                                print("* \(operation.opResultId ?? "")")
                            }
                            print("***********")
                            
                            
                            OfflineSyncManager.shared.offlineAwareCallbacks[createResult.opResultId!] = callback
                            OfflineSyncManager.shared.opResultIdToBlLocalId[createResult.opResultId!] = blLocalId
                        }
                        else if blPendingOperation == 1 {
                            // remove blLocalId, blLocalTimestamp, blPendingOperation
                            // OfflineSyncManager.shared.uow.update
                        }
                        else if blPendingOperation == 2 {
                            // OfflineSyncManager.shared.uow.delete
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
