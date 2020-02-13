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
    private var objectToDbReferences = [AnyHashable : Int]()
    
    private let psu = PersistenceServiceUtils()
    private let connectionManager = ConnectionManager()
    
    init(tableName: String) {
        self.tableName = tableName
        localManager = LocalManager(tableName: tableName)
        psu.setup(tableName: tableName)
    }
    
    func initLocalDatabase(whereClause: String, responseHandler: (() -> Void)!, errorHandler: ((Fault) -> Void)!) {
        var recordsCount: Any = 0
        let tableExists = localManager.tableExists(tableName: tableName)
        if tableExists {
            recordsCount = localManager.getNumberOfRecords(whereClause: nil)
            if recordsCount is Fault {
                errorHandler(recordsCount as! Fault)
            }
            if recordsCount is Int, recordsCount as! Int > 0 {
                errorHandler(Fault(message: "Table '\(tableName)' already has records"))
            }
        }
        else {
            localManager.createTableIfNotExist()
            let queryBuilder = DataQueryBuilder()
            queryBuilder.setWhereClause(whereClause: whereClause)
            queryBuilder.setPageSize(pageSize: 100)
            psu.find(queryBuilder: queryBuilder, responseHandler: { foundObjects in
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
        psu.find(queryBuilder: queryBuilder, responseHandler: { foundObjects in
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
    
    func clearLocalDatabase() {
        localManager.dropTable()
        //TransactionsManager.shared.removeAllTransactions()
    }
    
    func saveEventually(entity: inout Any) {
        localManager.createTableIfNotExist()
        let entityRef = getObjectReference(object: &entity)
        if var entityDict = entity as? [String : Any] {
            if ConnectionManager.isConnectedToNetwork() {
                saveEventuallyWhenOnline(entityDict: entityDict, entityRef: entityRef)
            }
            else {
                saveEventuallyWhenOffline(entityDict: &entityDict, entityRef: entityRef)
            }
        }
        else {
            // entity is not Dictionary
        }
    }
    
    func removeEventually() {
        if localManager.tableExists(tableName: tableName) {
            localManager.removeLocally(whereClause: "blLocalId = 3")
        }
    }
    
    func findLocal(whereClause: String?, properties: [String]?, limit: Int?, offset: Int?, sortBy: [String]?, groupBy: [String]?, having: String?, responseHandler: (([[String : Any]]) -> Void)!, errorHandler: ((Fault) -> Void)!) {
        let result = localManager.select(properties: properties, whereClause: whereClause, limit: limit, offset: offset, orderBy: sortBy, groupBy: groupBy, having: having)
        if result is [[String : Any]] {
            // ⚠️⚠️⚠️⚠️⚠️⚠️ remove unnecessary fields before return
            responseHandler(result as! [[String : Any]])
        }
        else if result is Fault {
            errorHandler(result as! Fault)
        }
    }
    
    // **************************************
    
    private func getObjectReference(object: inout Any) -> UnsafeMutablePointer<Any> {
        withUnsafeMutablePointer(to: &object, { reference in
            return reference
        })
    }
    
    private func saveEventuallyWhenOnline(entityDict: [String : Any], entityRef: UnsafeMutablePointer<Any>) {
        let semaphore = DispatchSemaphore(value: 0)
        if let objectId = entityDict["objectId"] as? String {
            if let blLocalId = objectToDbReferences[entityRef] {
                DispatchQueue.global().async {
                    self.psu.update(entity: entityDict, responseHandler: { updated in
                        let whereClause = "objectId='\(objectId)' AND blLocalId=\(blLocalId)"
                        if let localObjects = self.localManager.select(whereClause: whereClause) as? [[String : Any]],
                            localObjects.first != nil {
                            self.localManager.update(newValues: updated, whereClause: whereClause)
                        }
                        else {
                            let blLocalId = self.localManager.insert(object: updated)
                            self.objectToDbReferences[entityRef] = blLocalId
                        }
                        semaphore.signal()
                    }, errorHandler: { fault in
                        // ⚠️ call onSaveError
                        semaphore.signal()
                    })
                }
            }
            else {
                DispatchQueue.global().async {
                    self.psu.update(entity: entityDict, responseHandler: { updated in
                        let whereClause = "objectId='\(objectId)'"
                        if let localObjects = self.localManager.select(whereClause: whereClause) as? [[String : Any]],
                            localObjects.first != nil {
                            self.localManager.update(newValues: updated, whereClause: whereClause)
                        }
                        else {
                            let blLocalId = self.localManager.insert(object: updated)
                            self.objectToDbReferences[entityRef] = blLocalId
                        }
                        semaphore.signal()
                    }, errorHandler: { fault in
                        // ⚠️ call onSaveError
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
                        self.psu.update(entity: entityToUpdate, responseHandler: { updated in
                            self.localManager.update(newValues: updated, whereClause: whereClause)
                            semaphore.signal()
                        }, errorHandler: { fault in
                            // ⚠️ call onSaveError
                            semaphore.signal()
                        })
                    }
                }
                else {
                    DispatchQueue.global().async {
                        self.psu.create(entity: entityDict, responseHandler: { created in
                            let blLocalId = self.localManager.insert(object: created)
                            self.objectToDbReferences[entityRef] = blLocalId
                            semaphore.signal()
                        }, errorHandler: { fault in
                            // ⚠️ call onSaveError
                            semaphore.signal()
                        })
                    }
                }
            }
            else {
                DispatchQueue.global().async {
                    self.psu.create(entity: entityDict, responseHandler: { created in
                        let blLocalId = self.localManager.insert(object: created)
                        self.objectToDbReferences[entityRef] = blLocalId
                        semaphore.signal()
                    }, errorHandler: { fault in
                        // ⚠️ call onSaveError
                        semaphore.signal()
                    })
                }
            }
        }
        semaphore.wait()
        return
    }
    
    private func saveEventuallyWhenOffline(entityDict: inout [String : Any], entityRef: UnsafeMutablePointer<Any>) {
        // TODO
    }
}

// *********************************************************

/*
 func saveEventually(entity: [String : Any]) {
 if localManager == nil {
 initLocalManager()
 }
 if let objectId = entity["objectId"] as? String {
 localManager?.update(newValues: entity, whereClause: "objectId = '\(objectId)'", needTransaction: true)
 }
 else if let blLocalId = entity["blLocalId"] as? NSNumber {
 localManager?.update(newValues: entity, whereClause: "blLocalId = \(blLocalId)", needTransaction: true)
 }
 else {
 localManager?.insert(object: entity, needTransaction: true)
 }
 }
 
 func removeEventually(entity: [String : Any]) {
 if localManager == nil {
 initLocalManager()
 }
 localManager?.remove(entity: entity, needTransaction: true)
 }
 
 func getLocalId(entity: Any) -> NSNumber? {
 if let entity = entity as? [String : Any],
 let localId = entity["blLocalId"] as? NSNumber {
 return localId
 }
 else if let localId = localStoredObjects.getLocalId(forObject: entity as! AnyHashable) {
 return localId
 }
 return nil
 }
 
 func checkPropertiesForSync(tableName: String, dictionary: [String : Any]) -> [String : Any] {
 var resultDict = dictionary
 if let entity = getEntityForClassName(tableName) {
 let properties = getClassPropertiesWithType(entity: entity)
 for (key, type) in properties {
 if type == "B" {
 // property is Boolean
 if dictionary.keys.contains(key), let val = dictionary[key] as? NSNumber {
 let boolVal = val.boolValue
 resultDict[key] = boolVal
 }
 }
 }
 }
 return resultDict
 }
 
 func convertToGeometryType(dictionary: [String : Any]) -> [String : Any] {
 var resultDictionary = dictionary
 for (key, value) in dictionary {
 if let dictValue = value as? [String : Any] {
 if dictValue["___class"] as? String == BLPoint.geometryClassName || dictValue["type"] as? String == BLPoint.geoJsonType {
 resultDictionary[key] = try? GeoJSONParser.dictionaryToPoint(dictValue)
 }
 else if dictValue["___class"] as? String == BLLineString.geometryClassName || dictValue["type"] as? String == BLLineString.geoJsonType {
 resultDictionary[key] = try? GeoJSONParser.dictionaryToLineString(dictValue)
 }
 else if dictValue["___class"] as? String == BLPolygon.geometryClassName || dictValue["type"] as? String == BLPolygon.geoJsonType {
 resultDictionary[key] = try? GeoJSONParser.dictionaryToPolygon(dictValue)
 }
 }
 else if let dictValue = value as? String {
 if dictValue.contains(BLPoint.wktType) {
 resultDictionary[key] = try? BLPoint.fromWkt(dictValue)
 }
 else if dictValue.contains(BLLineString.wktType) {
 resultDictionary[key] = try? BLLineString.fromWkt(dictValue)
 }
 else if dictValue.contains(BLPolygon.wktType) {
 resultDictionary[key] = try? BLPolygon.fromWkt(dictValue)
 }
 }
 }
 return resultDictionary
 }
 
 private func convertFromGeometryType(dictionary: [String : Any]) -> [String : Any] {
 var resultDictionary = dictionary
 for (key, value) in dictionary {
 if let point = value as? BLPoint {
 resultDictionary[key] = point.asGeoJson()
 }
 else if let lineString = value as? BLLineString {
 resultDictionary[key] = lineString.asGeoJson()
 }
 else if let polygon = value as? BLPolygon {
 resultDictionary[key] = polygon.asGeoJson()
 }
 }
 return resultDictionary
 }*/
