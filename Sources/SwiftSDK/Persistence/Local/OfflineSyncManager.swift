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
    
    var dontSyncTables = [String]()
    var offlineAwareCallbacks = [String : OfflineAwareCallback]()
    var opResultIdToBlLocalId = [String : NSNumber]()
    var onSaveCallbacks = [String : OnSave]()
    var onRemoveCallbacks = [String : OnRemove]()
    var uow: UnitOfWork
    
    private init() {
        uow = UOWHelper.shared.getUOW()
        print("***** Sync operations on init: *****")
        for operation in uow.operations {
            print("* \(operation.opResultId ?? "")")
        }
        print("***********")
        
    }
    
    func processAllSyncOperations() {
        if uow.operations.count > 0 {
            
            print("***** Sync operations: *****")
            for operation in uow.operations {
                print("* \(operation.opResultId ?? "")")
            }
            print("***********")
            
            uow.execute(responseHandler: { uowResult in
                if uowResult.isSuccess,
                    let results = uowResult.results {
                    for (opResultId, operationResult) in results {
                        if var result = operationResult.result as? [String : Any],
                            let tableName = result["___class"] as? String {
                            var callback = self.offlineAwareCallbacks[opResultId]
                            if opResultId.contains("create") || opResultId.contains("update") {
                                if callback == nil {
                                    let onSaveCallback = self.onSaveCallbacks[tableName]
                                    callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onSaveCallback?.saveResponseHandler, remoteErrorHandler: onSaveCallback?.errorHandler)
                                }
                                result["blLocalId"] = self.opResultIdToBlLocalId[opResultId]
                                PersistenceServiceUtilsLocal.shared.saveEventually(tableName: tableName, entity: result, callback: callback)
                            }
                            else if opResultId.contains("delete") {
                                if callback == nil {
                                    let onRemoveCallback = self.onRemoveCallbacks[tableName]
                                    callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onRemoveCallback?.removeResponseHandler, remoteErrorHandler: onRemoveCallback?.errorHandler)
                                }
                                // TODO RemoveEventually
                            }
                        }
                    }
                    self.uow.operations.removeAll()
                    UOWHelper.shared.saveUOW(self.uow)
                }
                else if let uowError = uowResult.error,
                    let failedOperation = uowError.operation,
                    let opResultId = failedOperation.opResultId,
                    let tableName = failedOperation.tableName {
                    let fault = Fault(message: uowError.message)
                    var callback = self.offlineAwareCallbacks[opResultId]
                    if opResultId.contains("create") || opResultId.contains("update") {
                        if callback == nil {
                            let onSaveCallback = self.onSaveCallbacks[tableName]
                            callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onSaveCallback?.saveResponseHandler, remoteErrorHandler: onSaveCallback?.errorHandler)
                        }
                        callback?.remoteErrorHandler?(fault)
                    }
                    else if opResultId.contains("delete") {
                        if callback == nil {
                            let onRemoveCallback = self.onRemoveCallbacks[tableName]
                            callback = OfflineAwareCallback(localResponseHandler: nil, localErrorHandler: nil, remoteResponseHandler: onRemoveCallback?.removeResponseHandler, remoteErrorHandler: onRemoveCallback?.errorHandler)
                        }
                        callback?.remoteErrorHandler?(fault)
                    }
                }
            }, errorHandler: { fault in
                // handle error
            })
        }
    }
}