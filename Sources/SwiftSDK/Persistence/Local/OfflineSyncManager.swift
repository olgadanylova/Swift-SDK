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
    
    var onSaveCallbacks = [String : OnSave]()
    var onRemoveCallbacks = [String : OnRemove]()
    
    private let syncOperationsKey = "offlineSyncOperations"

    private var syncOperations = [SyncOperation]()
    private var autoSyncTables = [String]()
    
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
    
    // MARK: - Internal functions: process sync operations
    
    func processSyncOperations() {
        var deleteIndexes = [Int]()
        for i in 0..<syncOperations.count {
            let syncOperation = syncOperations[i]
            if let tableName = syncOperation.tableName,
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
            }
            deleteIndexes.append(i)
        }
        deleteIndexes.sort(by: { $1 < $0 })
        for i in deleteIndexes {
            removeSyncOperationAtIndex(i)
        }
    }
    
    func processSyncOperationsFromUsersDefaults() {
        if let syncOps = getSyncOperationsFromUserDefaults() {
            for (tableName, operationsArray) in syncOps {
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
}
