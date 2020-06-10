//
//  UOWHelper.swift
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

class UOWHelper {
    
    static let shared = UOWHelper()
    
    private let uowOfflineKey = "uow-offline"
    
    private init() { }
    
    func saveUOW(_ uow: UnitOfWork) {
        let uowJson = JSONUtils.shared.objectToJson(objectToParse: uow)
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(uowJson, forKey: uowOfflineKey)
    }
    
    func getUOW() -> UnitOfWork {
        let userDefaults = UserDefaults.standard
        if let uowDict = userDefaults.value(forKey: uowOfflineKey) as? [String : Any] {
            
            let uow = UnitOfWork()
            if let uowIsolationLevel = uowDict["isolationLevel"] as? Int {
                uow.isolationLevel = IsolationLevel(rawValue: uowIsolationLevel) ?? IsolationLevel.REPEATABLE_READ
            }
            if let uowOperations = uowDict["operations"] as? [[String : Any]] {
                var operations = [Operation]()
                for uowOperation in uowOperations {
                    if let tableName = uowOperation["tableName"] as? String,
                        let opResultId = uowOperation["opResultId"] as? String,
                        let payload = uowOperation["payload"] {
                        var operationType = OperationType.CREATE
                        if opResultId.contains("update") { operationType = .UPDATE }
                        else if opResultId.contains("delete") { operationType = .DELETE }
                        // TODO set/add/delete relations
                        let operation = Operation(operationType: operationType, tableName: tableName, opResultId: opResultId, payload: payload)
                        operations.append(operation)
                    }
                }
                uow.operations = operations
            }
            return uow
        }
        return UnitOfWork()
    }
    
    func removeUOW() {
        UserDefaults.standard.removeObject(forKey: uowOfflineKey)
    }
}
