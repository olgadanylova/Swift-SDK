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
    
    private var localManager: LocalManager
    private var tableName: String = "" 
    private var persistenceServiceUtils: PersistenceServiceUtils
    
    // MARK: - Init
    
    init(tableName: String) {
        self.tableName = tableName
        localManager = LocalManager(tableName: tableName)
        persistenceServiceUtils = PersistenceServiceUtils(tableName: self.tableName)
    }
    
    // MARK: - Init local database
    
    func initLocalDatabase(whereClause: String, responseHandler: (() -> Void)!, errorHandler: ((Fault) -> Void)!) {
        localManager.createTableIfNotExist()
        let recordsCount: Any = localManager.getNumberOfRecords(whereClause: nil)
        if recordsCount is Fault {
            errorHandler(recordsCount as! Fault)
        }
        if recordsCount is Int, recordsCount as! Int > 0 {
            errorHandler(Fault(message: "Table '\(tableName)' already has records"))
        }
        else {
            let queryBuilder = DataQueryBuilder()
            queryBuilder.setWhereClause(whereClause: whereClause)
            queryBuilder.setPageSize(pageSize: 100)
            persistenceServiceUtils.find(queryBuilder: queryBuilder, responseHandler: { foundObjects in
                if foundObjects.count > 0 {
                    for object in foundObjects {
                        self.localManager.initInsert(object: object, errorHandler: errorHandler)
                    }
                    queryBuilder.prepareNextPage()
                    self.nextPage(queryBuilder: queryBuilder, responseHandler: responseHandler, errorHandler: errorHandler)
                }
            }, errorHandler: { fault in
                errorHandler(fault)
            })
        }
    }
    
    private func nextPage(queryBuilder: DataQueryBuilder, responseHandler: (() -> Void)!, errorHandler: ((Fault) -> Void)!) {
        persistenceServiceUtils.find(queryBuilder: queryBuilder, responseHandler: { foundObjects in
            for object in foundObjects {
                self.localManager.initInsert(object: object, errorHandler: errorHandler)
            }
            if foundObjects.count == 0 {
                responseHandler()
                return
            }
            queryBuilder.prepareNextPage()
            self.nextPage(queryBuilder: queryBuilder, responseHandler: responseHandler, errorHandler: errorHandler)
        }, errorHandler: { fault in
            errorHandler(fault)
        })
    }
    
    // MARK: - Internal functions
    
    func clearLocalDatabase() {
        localManager.dropTable()
    }
    
    func saveEventually(entity: [String : Any], callback: OfflineAwareCallback?) {
        localManager.createTableIfNotExist()
        if ConnectionManager.isConnectedToNetwork() {
            saveEventuallyWhenOnline(entity, callback: callback)
        }
        else {
            saveEventuallyWhenOffline(entity, callback: callback)
        }
    }
    
    func removeEventually(entity: [String : Any], callback: OfflineAwareCallback?) {
        if ConnectionManager.isConnectedToNetwork() {
            removeEventuallyWhenOnline(entity, callback: callback)
        }
        else {
            removeEventuallyWhenOffline(entity, callback: callback)
        }
    }
    
    // MARK: - Private functions
    
    private func saveEventuallyWhenOnline(_ entity: [String : Any], callback: OfflineAwareCallback?) {
        let semaphore = DispatchSemaphore(value: 0)
        let objectId = entity["objectId"] as? String
        let blLocalId = entity["blLocalId"] as? NSNumber
        let wrappedResponseHandler = self.wrapLocalHandler(callback?.localResponseHandler)
        
        // create remotely - create locally
        if objectId == nil, blLocalId == nil {
            DispatchQueue.global().async {
                self.persistenceServiceUtils.create(entity: entity, responseHandler: { responseObject in
                    callback?.remoteResponseHandler?(responseObject)
                    self.localManager.insert(object: responseObject, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
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
            let localResult = localManager.select(whereClause: whereClause)
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
                            self.persistenceServiceUtils.update(entity: objectToUpdate, responseHandler: { responseObject in
                                callback?.remoteResponseHandler?(responseObject)
                                self.localManager.update(newValues: responseObject, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                                semaphore.signal()
                            }, errorHandler: { fault in
                                callback?.remoteErrorHandler?(fault)
                                semaphore.signal()
                            })
                        }
                    }
                    else {
                        DispatchQueue.global().async {
                            self.persistenceServiceUtils.create(entity: entity, responseHandler: { responseObject in
                                callback?.remoteResponseHandler?(responseObject)
                                self.localManager.update(newValues: responseObject, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
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
                        self.persistenceServiceUtils.create(entity: entity, responseHandler: { responseObject in
                            callback?.remoteResponseHandler?(responseObject)
                            self.localManager.insert(object: responseObject, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
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
                self.persistenceServiceUtils.update(entity: entity, responseHandler: { responseObject in
                    callback?.remoteResponseHandler?(responseObject)
                    let whereClause = "objectId='\(objectId!)'"
                    let localResult = self.localManager.select(whereClause: whereClause)
                    if let fault = localResult as? Fault {
                        callback?.localErrorHandler?(fault)
                        semaphore.signal()
                    }
                    else if let localObjects = localResult as? [[String : Any]] {
                        if localObjects.first != nil {
                            self.localManager.update(newValues: responseObject, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                            semaphore.signal()
                        }
                        else {
                            self.localManager.insert(object: responseObject, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
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
                self.persistenceServiceUtils.update(entity: entity, responseHandler: { responseObject in
                    callback?.remoteResponseHandler?(responseObject)
                    let whereClause = "objectId='\(objectId!)' AND blLocalId=\(blLocalId!)"
                    let localResult = self.localManager.select(whereClause: whereClause)
                    if let fault = localResult as? Fault {
                        callback?.localErrorHandler?(fault)
                        semaphore.signal()
                    }
                    else if let localObjects = localResult as? [[String : Any]] {
                        if localObjects.first != nil {
                            self.localManager.update(newValues: responseObject, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                            semaphore.signal()
                        }
                        else {
                            // ⚠️ is it correct?
                            self.localManager.insert(object: responseObject, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                            semaphore.signal()
                        }
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
    
    private func saveEventuallyWhenOffline(_ entity: [String : Any], callback: OfflineAwareCallback?) {
        let objectId = entity["objectId"] as? String
        let blLocalId = entity["blLocalId"] as? NSNumber
        let wrappedResponseHandler = self.wrapLocalHandler(callback?.localResponseHandler)
        
        // save locally
        if objectId == nil, blLocalId == nil {
            localManager.insert(object: entity, blPendingOperation: .create, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
        }
        // if record exists locally: update locally
        // if record doesn't exist locally: create locally
        else if objectId == nil, blLocalId != nil {
            let whereClause = "blLocalId=\(blLocalId!)"
            let localResult = localManager.select(whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
            }
            else if let localObjects = localResult as? [[String : Any]] {
                if localObjects.first != nil {
                    self.localManager.update(newValues: entity, whereClause: whereClause, blPendingOperation: .update, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
                else {
                    self.localManager.insert(object: entity, blPendingOperation: .create, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
            }
        }
        // if record exists locally: update locally
        // if record doesn't exist locally: create locally
        else if objectId != nil, blLocalId == nil {
            let whereClause = "objectId='\(objectId!)'"
            let localResult = localManager.select(whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
            }
            else if let localObjects = localResult as? [[String : Any]] {
                if localObjects.first != nil {
                    self.localManager.update(newValues: entity, whereClause: whereClause, blPendingOperation: .update, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
                else {
                    self.localManager.insert(object: entity, blPendingOperation: .create, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
            }
        }
        else if objectId != nil, blLocalId != nil {
            let whereClause = "objectId='\(objectId!)' AND blLocalId=\(blLocalId!)"
            let localResult = localManager.select(whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
            }
            else if let localObjects = localResult as? [[String : Any]] {
                if localObjects.first != nil {
                    self.localManager.update(newValues: entity, whereClause: whereClause, blPendingOperation: .update, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
                else {
                    // ⚠️ is it correct?
                    self.localManager.insert(object: entity, blPendingOperation: .create, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
            }
        }
    }
    
    private func removeEventuallyWhenOnline(_ entity: [String : Any], callback: OfflineAwareCallback?) {
        let semaphore = DispatchSemaphore(value: 0)
        let objectId = entity["objectId"] as? String
        let blLocalId = entity["blLocalId"] as? NSNumber
        let wrappedResponseHandler = self.wrapLocalHandler(callback?.localResponseHandler)
        
        // if record exists locally and objectId != nil: remove remotely - remove locally
        // if record exists locally and objectId == nil: remove locally
        if objectId == nil, blLocalId != nil {
            let whereClause = "blLocalId=\(blLocalId!)"
            let localResult = localManager.select(whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
                semaphore.signal()
            }
            else if let localObjects = localResult as? [[String : Any]],
                let localObject = localObjects.first {
                if let objId = localObject["objectId"] as? String {
                    DispatchQueue.global().async {
                        self.persistenceServiceUtils.removeById(objectId: objId, responseHandler: { response in
                            callback?.remoteResponseHandler?(response)
                            self.localManager.delete(whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                            semaphore.signal()
                        }, errorHandler: { fault in
                            callback?.remoteErrorHandler?(fault)
                            semaphore.signal()
                        })
                    }
                }
                else {
                    localManager.delete(whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                    semaphore.signal()
                }
            }
        }
        
        // remove remotely
        // if record exists locally: remove locally
        else if objectId != nil, blLocalId == nil {
            DispatchQueue.global().async {
                self.persistenceServiceUtils.removeById(objectId: objectId!, responseHandler: { response in
                    callback?.remoteResponseHandler?(response)
                    let whereClause = "objectId='\(objectId!)'"
                    let localResult = self.localManager.select(whereClause: whereClause)
                    if let fault = localResult as? Fault {
                        callback?.localErrorHandler?(fault)
                        semaphore.signal()
                    }
                    else if localResult is [[String : Any]] {
                        self.localManager.delete(whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
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
                self.persistenceServiceUtils.removeById(objectId: objectId!, responseHandler: { response in
                    callback?.remoteResponseHandler?(response)
                    let whereClause = "objectId='\(objectId!)' AND blLocalId=\(blLocalId!)"
                    let localResult = self.localManager.select(whereClause: whereClause)
                    if let fault = localResult as? Fault {
                        callback?.localErrorHandler?(fault)
                        semaphore.signal()
                    }
                    else if localResult is [[String : Any]] {
                        self.localManager.delete(whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
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
    
    private func removeEventuallyWhenOffline(_ entity: [String : Any], callback: OfflineAwareCallback?) {
        let objectId = entity["objectId"] as? String
        let blLocalId = entity["blLocalId"] as? NSNumber
        let wrappedResponseHandler = self.wrapLocalHandler(callback?.localResponseHandler)
        
        // if record exists locally: remove locally
        if objectId == nil, blLocalId != nil {
            let whereClause = "blLocalId=\(blLocalId!)"
            localManager.delete(whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
        }
        // if record exists locally: update with BlPendingOperation = .delete
        else if objectId != nil, blLocalId == nil {
            let whereClause = "objectId='\(objectId!)'"
            let localResult = localManager.select(whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
            }
            else if let localObjects = localResult as? [[String : Any]],
                localObjects.first != nil {
                localManager.update(newValues: entity, whereClause: whereClause, blPendingOperation: .delete, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
            }
        }
        // if record exists locally: update with BlPendingOperation = .delete
        else if objectId != nil, blLocalId != nil {
            let whereClause = "objectId='\(objectId!)' AND blLocalId=\(blLocalId!)"
            let localResult = localManager.select(whereClause: whereClause)
            if let fault = localResult as? Fault {
                callback?.localErrorHandler?(fault)
            }
            else if let localObjects = localResult as? [[String : Any]],
                localObjects.first != nil {
                localManager.update(newValues: entity, whereClause: whereClause, blPendingOperation: .delete, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
            }
        }
    }
    
    private func wrapLocalHandler(_ localResponseHandler: ((Any) -> Void)?) -> ((Any) -> Void) {
        let wrappedHandler: (Any) -> () = { response in
            if let responseDict = response as? [String : Any] {
                localResponseHandler?(PersistenceLocalHelper.shared.removeLocalFields(responseDict))
            }
        }
        return wrappedHandler
    }
}
