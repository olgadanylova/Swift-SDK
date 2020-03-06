//
//  OfflineSyncManager.swift
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

class OfflineSyncManager {
    
    static let shared = OfflineSyncManager()
    
    var autoSyncTables = [String]()
    var dontSyncTables = [String]()
    var onSaveCallbacks = [String : OnSave]()
    var onRemoveCallbacks = [String : OnRemove]()
    
    private let syncOperationsKey = "offlineSyncOperations"    
    private var syncOperations = [SyncOperation]()    
    
    // MARK: - Init
    
    private init() { }
    
    // MARK: - Internal functions
    
    func addSyncOperation(_ syncOperation: SyncOperation) {
        syncOperations.append(syncOperation)
        saveSyncOperationsToUserDefaults(syncOperations)
    }
    
    func getSyncOperations() -> [SyncOperation] {
        return syncOperations
    }
    
    func getSyncOperationsFromUserDefaults() -> [String : [[String : Any]]]? {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.value(forKey: syncOperationsKey) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? [String : [[String : Any]]]
        }
        return nil
    }
    
    func removeSyncOperationAtIndex(_ index: Int) {
        syncOperations.remove(at: index)
        saveSyncOperationsToUserDefaults(syncOperations)
    }
    
    func removeSyncOperations(tableName: String) {
        if !syncOperations.isEmpty {
            syncOperations = syncOperations.filter{ $0.tableName != tableName }
            saveSyncOperationsToUserDefaults(syncOperations)
        }
        else if var syncOps = getSyncOperationsFromUserDefaults() {
            syncOps[tableName]?.removeAll()
            saveSyncOperationsToUserDefaults(syncOps)
        }
    }
    
    func removeAllSyncOperations() {
        syncOperations.removeAll()
        saveSyncOperationsToUserDefaults(syncOperations)
    }
    
    // MARK: - Internal functions: process sync operations automatically
    
    func processAllSyncOperations() {
        if !self.syncOperations.isEmpty {
            processSyncOperations()
        }
        else {
            processSyncOperationsFromUsersDefaults()
        }
    }
    
    func processSyncOperationsForAutoSyncTables() {
        if !self.syncOperations.isEmpty {
            processSyncOperationsForSyncTables()
        }
        else {
            processSyncOperationsFromUsersDefaultsForSyncTables()
        }
    }
    
    // MARK: - Internal functions: process sync operations semi-automatically
    
    func processAllOperationsSemiAuto(_ callback: SyncCompletionCallback) {
        if !self.syncOperations.isEmpty {
            processSyncOperationsSemiAuto(table: nil, callback: callback)
        }
        else {
            processSyncOperationsSemiAutoFromUsersDefaults(table: nil, callback: callback)
        }
    }
    
    func processSyncOperationsForTable(table: String, callback: SyncCompletionCallback) {
        if !self.syncOperations.isEmpty {
            processSyncOperationsSemiAuto(table: table, callback: callback)
        }
        else {
            processSyncOperationsSemiAutoFromUsersDefaults(table: table, callback: callback)
        }
    }
    
    // MARK: - Private functions
    
    private func prepareSyncOperationsForUserDefaults(_ syncOps: [SyncOperation]) -> [String : [[String : Any]]] {
        var dictForUserDefaults = [String : [[String : Any]]]()
        for syncOperation in syncOps {
            if let tableName = syncOperation.tableName,
                let operationDesc = syncOperation.operation {
                var operationsArray = dictForUserDefaults[tableName]
                if operationsArray == nil {
                    operationsArray = [[String : Any]]()
                }
                operationsArray?.append(operationDesc)
                dictForUserDefaults[tableName] = operationsArray
            }
        }
        return dictForUserDefaults
    }
    
    private func saveSyncOperationsToUserDefaults(_ syncOps: [SyncOperation]) {
        let dictForUserDefaults = prepareSyncOperationsForUserDefaults(syncOps)
        saveSyncOperationsToUserDefaults(dictForUserDefaults)
    }
    
    private func saveSyncOperationsToUserDefaults(_ syncOps: [String : [[String : Any]]]) {
        let data = NSKeyedArchiver.archivedData(withRootObject: syncOps)
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(data, forKey: syncOperationsKey)
        userDefaults.synchronize()
    }
    
    private func processSyncOperations() {
        var deleteIndexes = [Int]()
        for i in 0..<syncOperations.count {
            let syncOperation = syncOperations[i]
            if let tableName = syncOperation.tableName, !dontSyncTables.contains(tableName),
                let operationDesc = syncOperation.operation,
                let blPendingOperation = operationDesc["blPendingOperation"] as? NSNumber {
                var callback = syncOperation.callback
                let psuLocal = PersistenceServiceUtilsLocal(tableName: tableName)
                if blPendingOperation.intValue == BlPendingOperation.create.rawValue ||
                    blPendingOperation.intValue == BlPendingOperation.update.rawValue {
                    if callback == nil {
                        let onSaveCallback = onSaveCallbacks[tableName]
                        callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onSaveCallback?.saveResponseHandler, remoteErrorHandler: onSaveCallback?.errorHandler)
                    }
                    psuLocal.saveEventually(entity: PersistenceLocalHelper.shared.removeAllLocalFields(operationDesc), callback: callback)
                }
                else if blPendingOperation.intValue == BlPendingOperation.delete.rawValue {
                    if callback == nil {
                        let onRemoveCallback = onRemoveCallbacks[tableName]
                        callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onRemoveCallback?.removeResponseHandler, remoteErrorHandler: onRemoveCallback?.errorHandler)
                    }
                    psuLocal.removeEventually(entity: operationDesc, callback: callback)
                }
                deleteIndexes.append(i)
            }
        }
        deleteIndexes.sort(by: { $1 < $0 })
        for i in deleteIndexes {
            removeSyncOperationAtIndex(i)
        }
    }
    
    private func processSyncOperationsForSyncTables() {
        var deleteIndexes = [Int]()
        for i in 0..<syncOperations.count {
            let syncOperation = syncOperations[i]
            if let tableName = syncOperation.tableName,
                autoSyncTables.contains(tableName),
                let operationDesc = syncOperation.operation,
                let blPendingOperation = operationDesc["blPendingOperation"] as? NSNumber {
                var callback = syncOperation.callback
                let psuLocal = PersistenceServiceUtilsLocal(tableName: tableName)
                if blPendingOperation.intValue == BlPendingOperation.create.rawValue ||
                    blPendingOperation.intValue == BlPendingOperation.update.rawValue {
                    if callback == nil {
                        let onSaveCallback = onSaveCallbacks[tableName]
                        callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onSaveCallback?.saveResponseHandler, remoteErrorHandler: onSaveCallback?.errorHandler)
                    }
                    psuLocal.saveEventually(entity: PersistenceLocalHelper.shared.removeAllLocalFields(operationDesc), callback: callback)
                }
                else if blPendingOperation.intValue == BlPendingOperation.delete.rawValue {
                    if callback == nil {
                        let onRemoveCallback = onRemoveCallbacks[tableName]
                        callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onRemoveCallback?.removeResponseHandler, remoteErrorHandler: onRemoveCallback?.errorHandler)
                    }
                    psuLocal.removeEventually(entity: operationDesc, callback: callback)
                }
                deleteIndexes.append(i)
            }
        }
        deleteIndexes.sort(by: { $1 < $0 })
        for i in deleteIndexes {
            removeSyncOperationAtIndex(i)
        }
    }
    
    private func processSyncOperationsFromUsersDefaults() {
        if let syncOps = getSyncOperationsFromUserDefaults() {
            for (tableName, operationsArray) in syncOps {
                for operationDesc in operationsArray {
                    if let blPendingOperation = operationDesc["blPendingOperation"] as? NSNumber {
                        let psuLocal = PersistenceServiceUtilsLocal(tableName: tableName)
                        if blPendingOperation.intValue == BlPendingOperation.create.rawValue ||
                            blPendingOperation.intValue == BlPendingOperation.update.rawValue {
                            let onSaveCallback = onSaveCallbacks[tableName]
                            let callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onSaveCallback?.saveResponseHandler, remoteErrorHandler: onSaveCallback?.errorHandler)
                            psuLocal.saveEventually(entity: PersistenceLocalHelper.shared.removeAllLocalFields(operationDesc), callback: callback)
                        }
                        else if blPendingOperation.intValue == BlPendingOperation.delete.rawValue {
                            let onRemoveCallback = onRemoveCallbacks[tableName]
                            let callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onRemoveCallback?.removeResponseHandler, remoteErrorHandler: onRemoveCallback?.errorHandler)
                            psuLocal.removeEventually(entity: operationDesc, callback: callback)
                        }
                    }
                }
                removeSyncOperations(tableName: tableName)
            }
        }
    }
    
    private func processSyncOperationsFromUsersDefaultsForSyncTables() {
        if let syncOps = getSyncOperationsFromUserDefaults() {
            for (tableName, operationsArray) in syncOps {
                if autoSyncTables.contains(tableName) {
                    // operationsArray = operationsArray.sorted(by: { ($0["blLocalTimestamp"] as? Int ?? 0) < ($1["blLocalTimestamp"] as? Int ?? 0) })
                    for operationDesc in operationsArray {
                        if let blPendingOperation = operationDesc["blPendingOperation"] as? NSNumber {
                            let psuLocal = PersistenceServiceUtilsLocal(tableName: tableName)
                            if blPendingOperation.intValue == BlPendingOperation.create.rawValue ||
                                blPendingOperation.intValue == BlPendingOperation.update.rawValue {
                                let onSaveCallback = onSaveCallbacks[tableName]
                                let callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onSaveCallback?.saveResponseHandler, remoteErrorHandler: onSaveCallback?.errorHandler)
                                psuLocal.saveEventually(entity: PersistenceLocalHelper.shared.removeAllLocalFields(operationDesc), callback: callback)
                            }
                            else if blPendingOperation.intValue == BlPendingOperation.delete.rawValue {
                                let onRemoveCallback = onRemoveCallbacks[tableName]
                                let callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onRemoveCallback?.removeResponseHandler, remoteErrorHandler: onRemoveCallback?.errorHandler)
                                psuLocal.removeEventually(entity: operationDesc, callback: callback)
                            }
                        }
                    }
                    removeSyncOperations(tableName: tableName)
                }
            }
        }
    }
    
    // returns true if we need to remove stored operation transaction after processing it
    private func processOperation(tableName: String, operationDesc: [String : Any], i: Int,
                                  createSuccess: inout [String : [Any]], updateSuccess: inout [String : [Any]], deleteSuccess: inout [String : [Any]],
                                  createErrors: inout [String : [SyncError]], updateErrors: inout [String : [SyncError]], deleteErrors: inout [String : [SyncError]]) -> Bool {
        var needRemoveAfterProcess = false
        if let blPendingOperation = operationDesc["blPendingOperation"] as? NSNumber {
            let psuLocal = PersistenceServiceUtilsLocal(tableName: tableName)
            if blPendingOperation.intValue == BlPendingOperation.create.rawValue ||
                blPendingOperation.intValue == BlPendingOperation.update.rawValue {
                let syncObject = psuLocal.saveEventuallySemiAutoSync(PersistenceLocalHelper.shared.removeLocalTimestampAndPendingOpFields(operationDesc))
                if syncObject.syncObject == nil, syncObject.syncError == nil {
                    needRemoveAfterProcess = true
                }
                else {
                    if let syncedObject = syncObject.syncObject {
                        let syncOperation = syncObject.syncOperation
                        if syncOperation == .create {
                            var objects = createSuccess[tableName]
                            if objects == nil {
                                objects = [Any]()
                            }
                            objects?.append(syncedObject)
                            createSuccess[tableName] = objects
                            needRemoveAfterProcess = true
                        }
                        else if syncOperation == .update {
                            var objects = updateSuccess[tableName]
                            if objects == nil {
                                objects = [Any]()
                            }
                            objects?.append(syncedObject)
                            updateSuccess[tableName] = objects
                            needRemoveAfterProcess = true
                        }
                    }
                    else if let syncError = syncObject.syncError {
                        let syncOperation = syncObject.syncOperation
                        if syncOperation == .create {
                            var errors = createErrors[tableName]
                            if errors == nil {
                                errors = [SyncError]()
                            }
                            errors?.append(syncError)
                            createErrors[tableName] = errors
                        }
                        else if syncOperation == .update {
                            var errors = updateErrors[tableName]
                            if errors == nil {
                                errors = [SyncError]()
                            }
                            errors?.append(syncError)
                            updateErrors[tableName] = errors
                        }
                    }
                }
            }
            else if blPendingOperation.intValue == BlPendingOperation.delete.rawValue {
                let syncObject = psuLocal.removeEventuallySemiAutoSync(PersistenceLocalHelper.shared.removeAllLocalFields(operationDesc))
                if syncObject.syncObject == nil, syncObject.syncError == nil {
                    needRemoveAfterProcess = true
                }
                else if syncObject.syncOperation == .delete {
                    if let syncedObject = syncObject.syncObject {
                        var objects = deleteSuccess[tableName]
                        if objects == nil {
                            objects = [Any]()
                        }
                        objects?.append(syncedObject)
                        deleteSuccess[tableName] = objects
                        needRemoveAfterProcess = true
                    }
                    else if let syncError = syncObject.syncError {
                        var errors = deleteErrors[tableName]
                        if errors == nil {
                            errors = [SyncError]()
                        }
                        errors?.append(syncError)
                        needRemoveAfterProcess = true
                    }
                }
            }
        }
        return needRemoveAfterProcess
    }
    
    private func processSyncOperationsSemiAuto(table: String?, callback: SyncCompletionCallback) {
        var createSuccess = [String : [Any]]()
        var updateSuccess = [String : [Any]]()
        var deleteSuccess = [String : [Any]]()
        
        var createErrors = [String : [SyncError]]()
        var updateErrors = [String : [SyncError]]()
        var deleteErrors = [String : [SyncError]]()
        
        var deleteIndexes = [Int]()
        for i in 0..<syncOperations.count {            
            let syncOperation = syncOperations[i]
            if table != nil {
                if let tableName = syncOperation.tableName, !dontSyncTables.contains(tableName), table == tableName,
                    let operationDesc = syncOperation.operation {
                    if processOperation(tableName: tableName, operationDesc: operationDesc, i: i, createSuccess: &createSuccess, updateSuccess: &updateSuccess, deleteSuccess: &deleteSuccess, createErrors: &createErrors, updateErrors: &updateErrors, deleteErrors: &deleteErrors) {
                        deleteIndexes.append(i)
                    }
                }
            }
            else if let tableName = syncOperation.tableName, !dontSyncTables.contains(tableName),
                let operationDesc = syncOperation.operation {
                if processOperation(tableName: tableName, operationDesc: operationDesc, i: i, createSuccess: &createSuccess, updateSuccess: &updateSuccess, deleteSuccess: &deleteSuccess, createErrors: &createErrors, updateErrors: &updateErrors, deleteErrors: &deleteErrors) {
                    deleteIndexes.append(i)
                }
            }
        }
        deleteIndexes.sort(by: { $1 < $0 })
        for i in deleteIndexes {
            removeSyncOperationAtIndex(i)
        }
        callback.syncCompleted?(generateSyncStatusDict(createSuccess, updateSuccess, deleteSuccess, createErrors, updateErrors, deleteErrors))
    }
    
    private func processSyncOperationsSemiAutoFromUsersDefaults(table: String?, callback: SyncCompletionCallback) {
        var createSuccess = [String : [Any]]()
        var updateSuccess = [String : [Any]]()
        var deleteSuccess = [String : [Any]]()
        
        var createErrors = [String : [SyncError]]()
        var updateErrors = [String : [SyncError]]()
        var deleteErrors = [String : [SyncError]]()
        
        var processedSyncOps = [String : [[String : Any]]]()
        
        if let syncOps = getSyncOperationsFromUserDefaults() {
            for (tableName, var operationsArray) in syncOps {
                var deleteIndexes = [Int]()
                if table != nil, table == tableName, !dontSyncTables.contains(tableName) {
                    for i in 0..<operationsArray.count {
                        let operationDesc = operationsArray[i]
                        if processOperation(tableName: tableName, operationDesc: operationDesc, i: i, createSuccess: &createSuccess, updateSuccess: &updateSuccess, deleteSuccess: &deleteSuccess, createErrors: &createErrors, updateErrors: &updateErrors, deleteErrors: &deleteErrors) {
                            deleteIndexes.append(i)
                        }
                    }
                }
                else if !dontSyncTables.contains(tableName) {
                    for i in 0..<operationsArray.count {
                        let operationDesc = operationsArray[i]
                        if processOperation(tableName: tableName, operationDesc: operationDesc, i: i, createSuccess: &createSuccess, updateSuccess: &updateSuccess, deleteSuccess: &deleteSuccess, createErrors: &createErrors, updateErrors: &updateErrors, deleteErrors: &deleteErrors) {
                            deleteIndexes.append(i)
                        }
                    }
                }
                deleteIndexes.sort(by: { $1 < $0 })
                for i in deleteIndexes {
                    operationsArray.remove(at: i)
                }
                processedSyncOps[tableName] = operationsArray
            }
            saveSyncOperationsToUserDefaults(processedSyncOps)
            callback.syncCompleted?(generateSyncStatusDict(createSuccess, updateSuccess, deleteSuccess, createErrors, updateErrors, deleteErrors))
        }
    }
    
    private func generateSyncStatusDict(_ createSuccess: [String : [Any]], _ updateSuccess: [String : [Any]], _ deleteSuccess: [String : [Any]],
                                        _ createErrors: [String : [SyncError]], _ updateErrors: [String : [SyncError]], _ deleteErrors: [String : [SyncError]]) -> [String : SyncStatusReport] {
        var syncTables = [String]()
        syncTables.append(contentsOf: createSuccess.keys)
        syncTables.append(contentsOf: updateSuccess.keys)
        syncTables.append(contentsOf: deleteSuccess.keys)
        syncTables.append(contentsOf: createErrors.keys)
        syncTables.append(contentsOf: updateErrors.keys)
        syncTables.append(contentsOf: deleteErrors.keys)
        syncTables = Array(Set(syncTables))
        
        var syncStatusDict = [String : SyncStatusReport]()
        for tableName in syncTables {            
            let createSuccessObjects = prepareSuccessObjectsForRepsonse(createSuccess[tableName])
            let updateSuccessObjects = prepareSuccessObjectsForRepsonse(updateSuccess[tableName])
            let deleteSuccessObjects = prepareSuccessObjectsForRepsonse(deleteSuccess[tableName])
            
            let createErrorsObjects = prepareFailureObjectsForRepsonse(createErrors[tableName])
            let updateErrorsObjects = prepareFailureObjectsForRepsonse(updateErrors[tableName])
            let deleteErrorsObjects = prepareFailureObjectsForRepsonse(deleteErrors[tableName])
            
            let successfulCompletion = SyncSuccess(created: createSuccessObjects, updated: updateSuccessObjects, deleted: deleteSuccessObjects)
            let failedCompletion = SyncFailure(createErrors: createErrorsObjects, updateErrors: updateErrorsObjects, deleteErrors: deleteErrorsObjects)
            syncStatusDict[tableName] = SyncStatusReport(successfulCompletion: successfulCompletion, failedCompletion: failedCompletion)
        }
        return syncStatusDict
    }
    
    private func prepareSuccessObjectsForRepsonse(_ successObjects: [Any]?) -> [Any]? {
        if let successObjects = successObjects as? [[String : Any]], !successObjects.isEmpty {
            var resultArray = [[String : Any]]()
            for var object in successObjects {
                object = PersistenceLocalHelper.shared.prepareOfflineObjectForResponse(object)
                resultArray.append(object)
            }
            return resultArray
        }
        return nil
    }
    
    private func prepareFailureObjectsForRepsonse(_ failureObjects: [SyncError]?) -> [SyncError]? {
        if let failureObjects = failureObjects, !failureObjects.isEmpty {
            var resultArray = [SyncError]()
            for failureObject in failureObjects {
                if let object = failureObject.object as? [String : Any] {
                    let syncError = SyncError(object: PersistenceLocalHelper.shared.prepareOfflineObjectForResponse(object), error: failureObject.error)
                    resultArray.append(syncError)
                }
            }
            return resultArray
        }
        return nil
    }
}
