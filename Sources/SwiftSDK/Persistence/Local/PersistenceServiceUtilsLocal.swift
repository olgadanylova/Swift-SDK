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
    
    private let connectionManager = ConnectionManager()
    
    private var localManager: LocalManager
    private var tableName: String = ""
    private var objectToDbReferences = [AnyHashable : Int]()
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
    
    func saveEventually(entity: inout Any, callback: OfflineAwareCallback?) {
        localManager.createTableIfNotExist()
        let entityRef = getObjectReference(object: &entity)
        if let entityDict = entity as? [String : Any] {
            if ConnectionManager.isConnectedToNetwork() {
                saveEventuallyWhenOnline(entityDict: entityDict, entityRef: entityRef, callback: callback)
            }
            else {
                saveEventuallyWhenOffline(entityDict: entityDict, entityRef: entityRef, callback: callback)
            }
        }
        else {
            // entity is not Dictionary
        }
    }
    
    func removeEventually(entity: inout Any, callback: OfflineAwareCallback?) {
        let entityRef = getObjectReference(object: &entity)
        if var entityDict = entity as? [String : Any] {
            if ConnectionManager.isConnectedToNetwork() {
                removeEventuallyWhenOnline(entityDict: entityDict, entityRef: entityRef, callback: callback)
            }
            else {
                removeEventuallyWhenOffline(entityDict: &entityDict, entityRef: entityRef, callback: callback)
            }
        }
        else {
            // entity is not Dictionary
        }
    }
    
    // MARK: - Private functions
    
    private func getObjectReference(object: inout Any) -> UnsafeMutablePointer<Any> {
        withUnsafeMutablePointer(to: &object, { reference in
            return reference
        })
    }
    
    private func saveEventuallyWhenOnline(entityDict: [String : Any], entityRef: UnsafeMutablePointer<Any>, callback: OfflineAwareCallback?) {
        let semaphore = DispatchSemaphore(value: 0)
        if let objectId = entityDict["objectId"] as? String {
            if let blLocalId = objectToDbReferences[entityRef] {
                DispatchQueue.global().async {
                    self.persistenceServiceUtils.update(entity: entityDict, responseHandler: { updated in
                        callback?.remoteResponseHandler?(updated)
                        let whereClause = "objectId='\(objectId)' AND blLocalId=\(blLocalId)"
                        if let localObjects = self.localManager.select(whereClause: whereClause) as? [[String : Any]],
                            localObjects.first != nil {
                            let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                            self.localManager.update(newValues: updated, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                        }
                        else {
                            let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                            self.localManager.insert(object: updated, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                        }
                        semaphore.signal()
                    }, errorHandler: { fault in
                        callback?.remoteErrorHandler?(fault)
                        semaphore.signal()
                    })
                }
            }
            else {
                DispatchQueue.global().async {
                    self.persistenceServiceUtils.update(entity: entityDict, responseHandler: { updated in
                        callback?.remoteResponseHandler?(updated)
                        let whereClause = "objectId='\(objectId)'"
                        if let localObjects = self.localManager.select(whereClause: whereClause) as? [[String : Any]],
                            localObjects.first != nil {
                            let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                            self.localManager.update(newValues: updated, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                        }
                        else {
                            let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                            self.localManager.insert(object: updated, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                        }
                        semaphore.signal()
                    }, errorHandler: { fault in
                        callback?.remoteErrorHandler?(fault)
                        semaphore.signal()
                    })
                }
            }
        }
        else {
            if let blLocalId = objectToDbReferences[entityRef] {
                let whereClause = "blLocalId=\(blLocalId)"
                if let localObjects = self.localManager.select(whereClause: whereClause) as? [[String : Any]],
                    let localObject = localObjects.first,
                    let objectId = localObject["objectId"] as? String {
                    var entityToUpdate = entityDict
                    entityToUpdate["objectId"] = objectId
                    DispatchQueue.global().async {
                        self.persistenceServiceUtils.update(entity: entityToUpdate, responseHandler: { updated in
                            callback?.remoteResponseHandler?(updated)
                            let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                            self.localManager.update(newValues: updated, whereClause: whereClause, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                            semaphore.signal()
                        }, errorHandler: { fault in
                            callback?.remoteErrorHandler?(fault)
                            semaphore.signal()
                        })
                    }
                }
                else {
                    DispatchQueue.global().async {
                        self.persistenceServiceUtils.create(entity: entityDict, responseHandler: { created in
                            callback?.remoteResponseHandler?(created)
                            let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                            self.localManager.insert(object: created, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
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
                    self.persistenceServiceUtils.create(entity: entityDict, responseHandler: { created in
                        callback?.remoteResponseHandler?(created)
                        let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                        self.localManager.insert(object: created, blPendingOperation: .none, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                        semaphore.signal()
                    }, errorHandler: { fault in
                        callback?.remoteErrorHandler?(fault)
                        semaphore.signal()
                    })
                }
            }
        }
        semaphore.wait()
        return
    }
    
    private func saveEventuallyWhenOffline(entityDict: [String : Any], entityRef: UnsafeMutablePointer<Any>, callback: OfflineAwareCallback?) {
        if let objectId = entityDict["objectId"] as? String {
            if let blLocalId = objectToDbReferences[entityRef] {
                let whereClause = "objectId='\(objectId)' AND blLocalId=\(blLocalId)"
                if let localObjects = localManager.select(whereClause: whereClause) as? [[String : Any]],
                    localObjects.first != nil {
                    let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                    self.localManager.update(newValues: entityDict, whereClause: whereClause, blPendingOperation: .update, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
                else {
                    let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                    self.localManager.insert(object: entityDict, blPendingOperation: .create, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
            }
            else {
                let whereClause = "objectId='\(objectId)'"
                if let localObjects = localManager.select(whereClause: whereClause) as? [[String : Any]],
                    localObjects.first != nil {
                    let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                    self.localManager.update(newValues: entityDict, whereClause: whereClause, blPendingOperation: .update, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
                else {
                    let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                    self.localManager.insert(object: entityDict, blPendingOperation: .create, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
            }
        }
        else {
            if let blLocalId = objectToDbReferences[entityRef] {
                let whereClause = "blLocalId=\(blLocalId)"
                if let localObjects = self.localManager.select(whereClause: whereClause) as? [[String : Any]],
                    localObjects.first != nil {
                    let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                    self.localManager.update(newValues: entityDict, whereClause: whereClause, blPendingOperation: .update, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
                else {
                    let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                    self.localManager.insert(object: entityDict, blPendingOperation: .create, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                }
            }
            else {
                let wrappedResponseHandler = self.wrapSaveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                self.localManager.insert(object: entityDict, blPendingOperation: .create, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
            }
        }
    }
    
    private func removeEventuallyWhenOnline(entityDict: [String : Any], entityRef: UnsafeMutablePointer<Any>, callback: OfflineAwareCallback?) {
        let semaphore = DispatchSemaphore(value: 0)
        if let objectId = entityDict["objectId"] as? String {
            DispatchQueue.global().async {
                self.persistenceServiceUtils.removeById(objectId: objectId, responseHandler: { removed in
                    callback?.remoteResponseHandler?(removed)
                    let whereClause = "objectId='\(objectId)'"
                    let wrappedResponseHandler = self.wrapRemoveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                    self.localManager.delete(whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                    semaphore.signal()
                }, errorHandler: { fault in
                    callback?.remoteErrorHandler?(fault)
                    semaphore.signal()
                })
            }
        }
        else if let blLocalId = objectToDbReferences[entityRef] {
            let whereClause = "blLocalId=\(blLocalId)"
            if let localObjects = localManager.select(whereClause: whereClause) as? [[String : Any]],
                let objectToDelete = localObjects.first,
                let objectId = objectToDelete["objectId"] as? String {
                DispatchQueue.global().async {
                    self.persistenceServiceUtils.removeById(objectId: objectId, responseHandler: { removed in
                        callback?.remoteResponseHandler?(removed)
                        let wrappedResponseHandler = self.wrapRemoveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                        self.localManager.delete(whereClause: whereClause, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
                        semaphore.signal()
                    }, errorHandler: { fault in
                        callback?.remoteErrorHandler?(fault)
                        semaphore.signal()
                    })
                }
            }
        }
        semaphore.wait()
        return
    }
    
    private func removeEventuallyWhenOffline(entityDict: inout [String : Any], entityRef: UnsafeMutablePointer<Any>, callback: OfflineAwareCallback?) {
        if let objectId = entityDict["objectId"] as? String {
            let result = localManager.select(whereClause: "objectId='\(objectId)'")
            if let objectToDelete = (result as? [[String : Any]])?.first {
                let wrappedResponseHandler = self.wrapRemoveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
                localManager.update(newValues: objectToDelete, whereClause: "objectId='\(objectId)'", blPendingOperation: .delete, localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
            }
            else if result is Fault {
                callback?.localErrorHandler?(result as! Fault)
            }
        }
        else if let blLocalId = objectToDbReferences[entityRef],
            localManager.recordExists(whereClause: "blLocalId=\(blLocalId)") {
            let wrappedResponseHandler = self.wrapRemoveLocalHandler(callback?.localResponseHandler, entityRef: entityRef)
            localManager.delete(whereClause: "blLocalId=\(blLocalId)", localResponseHandler: wrappedResponseHandler, localErrorHandler: callback?.localErrorHandler)
        }
    }
    
    private func wrapSaveLocalHandler(_ localResponseHandler: ((Any) -> Void)?, entityRef: UnsafeMutablePointer<Any>) -> ((Any) -> Void) {
        let wrappedHandler: (Any) -> () = { response in
            if let response = response as? [String : Any],
                let localId = response["blLocalId"] as? Int64 {
                self.objectToDbReferences[entityRef] = Int(localId)
                localResponseHandler?(self.persistenceServiceUtils.removeLocalFields(response))
            }
        }
        return wrappedHandler
    }
    
    private func wrapRemoveLocalHandler(_ localResponseHandler: ((Any) -> Void)?, entityRef: UnsafeMutablePointer<Any>) -> ((Any) -> Void) {
        let wrappedHandler: (Any) -> () = { response in
            self.objectToDbReferences[entityRef] = nil
            if let response = response as? [String : Any] {
                localResponseHandler?(self.persistenceServiceUtils.removeLocalFields(response))
            }
        }
        return wrappedHandler
    }
    
    // ****************************************************
    
    // remove later
    
    func findLocal(whereClause: String?, properties: [String]?, limit: Int?, offset: Int?, sortBy: [String]?, groupBy: [String]?, having: String?, responseHandler: (([[String : Any]]) -> Void)!, errorHandler: ((Fault) -> Void)!) {
        let result = localManager.select(properties: properties, whereClause: whereClause, limit: limit, offset: offset, orderBy: sortBy, groupBy: groupBy, having: having)
        if result is [[String : Any]] {
            responseHandler(result as! [[String : Any]])
        }
        else if result is Fault {
            errorHandler(result as! Fault)
        }
    }
}
