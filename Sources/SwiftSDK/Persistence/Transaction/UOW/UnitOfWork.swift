//
//  UnitOfWork.swift
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

@objc public enum IsolationLevel: Int {
    case REPEATABLE_READ
    case READ_COMMITTED
    case READ_UNCOMMITTED
    case SERIALIZABLE
}

// **************************************************************

enum uowProperties {
    static let referenceMarker = "___ref"
    static let opResultId = "opResultId"
    static let resultIndex = "resultIndex"
    static let propName = "propName"
}

// **************************************************************

@objcMembers public class UnitOfWork: NSObject {
    
    var isolation: IsolationLevel?
    var operations = [Operation]()
    
    private let psu = PersistenceServiceUtils()
    private let processResponse = ProcessResponse.shared
    private let payloadHelper = PayloadHelper.shared
    private let transactionHelper = TransactionHelper.shared
    
    private var uowCreate: UnitOfWorkCreate
    private var uowUpdate: UnitOfWorkUpdate
    
    public override init() {
        uowCreate = UnitOfWorkCreate()
        uowUpdate = UnitOfWorkUpdate()
    }
    
    public convenience init(isolation: IsolationLevel) {
        self.init()
        self.isolation = isolation
    }
    
    // create
    
    public func create(tableName: String, entity: [String : Any]) -> OpResult {
        let (operation, opRes) = uowCreate.create(tableName: tableName, entity: entity)
        operations.append(operation)
        return opRes
    }
    
    public func create(entity: Any) -> OpResult {
        let (tableName, entityDictionary) = transactionHelper.tableAndDictionaryFromEntity(entity: entity)
        let (operation, opRes) = uowCreate.create(tableName: tableName, entity: entityDictionary as! [String : Any])
        operations.append(operation)
        return opRes
    }
    
    // bulk create
    
    public func bulkCreate(tableName: String, entities: [[String : Any]]) -> OpResult {
        let (operation, opRes) = uowCreate.bulkCreate(tableName: tableName, entities: entities)
        operations.append(operation)
        return opRes
    }
    
    public func bulkCreate(entities: [Any]) -> OpResult {
        let (tableName, dictArray) = transactionHelper.tableAndDictionaryFromEntity(entity: entities)
        let (operation, opRes) = uowCreate.bulkCreate(tableName: tableName, entities: dictArray as! [[String : Any]])
        operations.append(operation)
        return opRes
    }
    
    // update
    public func update(tableName: String, entity: [String : Any]) -> OpResult {
        let (operation, opRes) = uowUpdate.update(tableName: tableName, entity: entity)
        operations.append(operation)
        return opRes
    }
    
    public func update(entity: Any) -> OpResult {
        let (tableName, entityDictionary) = transactionHelper.tableAndDictionaryFromEntity(entity: entity)
        let (operation, opRes) = uowUpdate.update(tableName: tableName, entity: entityDictionary as! [String : Any])
        operations.append(operation)
        return opRes
    }
    
    public func update(result: OpResult, changes: [String : Any]) -> OpResult {
        let (operation, opRes) = uowUpdate.update(result: result, changes: changes)
        
    }
    
    // execute
    public func execute(responseHandler: ((UnitOfWorkResult) -> Void)!) {
        let headers = ["Content-Type": "application/json"]

        let parameters = payloadHelper.generatePayload(isolation: isolation, operations: operations)
        BackendlessRequestManager(restMethod: "transaction/unit-of-work", httpMethod: .post, headers: headers, parameters: parameters).makeRequest(getResponse: { response in
            if let result = self.processResponse.adapt(response: response, to: JSON.self),
                var resultDictionary = (result as! JSON).dictionaryObject {
                resultDictionary = self.psu.convertToGeometryType(dictionary: resultDictionary)
                responseHandler(self.processResponse.adaptToUnitOfWorkResult(unitOfWorkDictionary: resultDictionary))
            }
        })
    }
}
