//
//  LocalManager.swift
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

import SQLite3

enum BlPendingOperation: Int {
    case create
    case update
    case delete
    case none
}

public class LocalManager {
    
    private var dbInstance: OpaquePointer?
    private var dbUrl: URL!
    private var dbOpened = false
    
    private let tableName: String
    private let dataTypesUtils = DataTypesUtils.shared
    /*private let transactionsManager = TransactionsManager.shared
    private let connectionManager = ConnectionManager.shared
    private let callbacksManager = CallbacksManager.shared
    private let localUtils = LocalUtils.shared*/
    private let SQLITE_TRANSIENT = unsafeBitCast(OpaquePointer(bitPattern: -1), to: sqlite3_destructor_type.self)
    
    public init(tableName: String) {
        self.tableName = tableName
        dbUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("myDB.sqlite")
        openDB()
        if !tableName.isEmpty {
            createTableIfNotExist()
        }
    }
    
    deinit {
        closeDB()
    }
    
    // ***************************************************************
    
    private func openDB() {
        if sqlite3_open(dbUrl.path, &dbInstance) == SQLITE_OK {
            dbOpened = true
            return
        }
        dbOpened = false
    }
    
    private func closeDB() {
        sqlite3_close(dbInstance)
        dbOpened = false
    }
    
    private func parseWhereClauseWithGrammar(_ whereClause: String) -> String {
        let input = ANTLRInputStream(whereClause)
        let lexer = WhereClauseGrammarLexer(input)
        let tokenStream = CommonTokenStream(lexer)
        guard let parser = try? WhereClauseGrammarParser(tokenStream) else { return whereClause }
        parser.setBuildParseTree(true)
        
        guard let ctx = try? parser.expression() else { return whereClause }
        
        let visitor = GrammarVisitor()
        if let result = visitor.visit(ctx) {
            return result
        }
        return whereClause
    }
    
    private func getColumns() -> [String : String] {
        var columns = [String : String]()
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, "PRAGMA table_info('\(tableName)')", -1, &statement, nil) == SQLITE_OK {
            while(sqlite3_step(statement) == SQLITE_ROW) {
                let name = String(cString: sqlite3_column_text(statement, 1))
                let type = String(cString: sqlite3_column_text(statement, 2))
                columns[name] = type
            }
        }
        sqlite3_finalize(statement)
        return columns
    }
    
    private func addColumn(columnName: String, columnType: String) {
        let cmd = "ALTER TABLE \(tableName) ADD COLUMN \(columnName) \(columnType)"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
            }
        }
        sqlite3_finalize(statement)
    }
    
    private func getFieldType(value: Any) -> String {
        var fieldType = "REAL"
        if (value is NSInteger) {
            fieldType = "INTEGER"
        }
        else if value is String {
            fieldType = "TEXT"
        }
        return fieldType
    }
    
    private func prepareInsertCommand(object: [String : Any]) -> String {
        let blLocalTimestamp = dataTypesUtils.dateToInt(date: Date())
        let blPendingOperation = BlPendingOperation.create.rawValue
        var cmd = "INSERT INTO \(tableName) (blLocalTimestamp, blPendingOperation, objectId, ownerId, created, updated"
        for key in object.keys {
            if key != "blLocalTimestamp", key != "blLocalTimestamp", key != "objectId", key != "ownerId", key != "created", key != "updated", key != "___class", !(object[key] is NSNull) {
                cmd += ", \(key)"
            }
        }
        cmd += ") VALUES (\(blLocalTimestamp), \(blPendingOperation)"
        if let objectId = object["objectId"] as? String {
            cmd += ", '\(objectId)'"
        }
        else {
            cmd += ", null"
        }
        if let ownerId = object["ownerId"] as? String {
            cmd += ", '\(ownerId)'"
        }
        else {
            cmd += ", null"
        }
        if let created = object["created"] as? NSNumber {
            cmd += ", \(created)"
        }
        else {
            //cmd += ", null"
            cmd += ", \(blLocalTimestamp)"
        }
        if let updated = object["updated"] as? NSNumber {
            cmd += ", \(updated)"
        }
        else {
            cmd += ", null"
        }
        let existingColumns = getColumns()
        for (key, value) in object {
            if key != "blLocalTimestamp", key != "blLocalTimestamp", key != "objectId", key != "ownerId", key != "created", key != "updated", key != "___class", !(value is NSNull) {
                if value is Date {
                    cmd += ", \(dataTypesUtils.dateToInt(date: value as! Date))"
                }
                else if value is Bool {
                    if value as! Bool == true {
                        cmd += ", 1"
                    }
                    else {
                        cmd += ", 0"
                    }
                }
                else if value is String {
                    cmd += ", '\(value)'"
                }
                else {
                    cmd += ", \(value)"
                }
                if !existingColumns.keys.contains(key) {
                    addColumn(columnName: key, columnType: getFieldType(value: value))
                }
            }
        }
        cmd += ")"
        return cmd
    }
    
    // ***************************************************************
    
    func createTableIfNotExist() {
        let cmd = "CREATE TABLE IF NOT EXISTS \(tableName) (blLocalId INTEGER PRIMARY KEY AUTOINCREMENT, blLocalTimestamp INTEGER, blPendingOperation INTEGER, objectId TEXT, ownerId TEXT, created INTEGER, updated INTEGER)"
        sqlite3_exec(dbInstance, cmd, nil, nil, nil)
    }
    
    func getTables() -> [String] {
        var tables = [String]()
        var statement: OpaquePointer?
        let cmd = "SELECT name FROM sqlite_master WHERE type='table'"
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK {
            while(sqlite3_step(statement) == SQLITE_ROW) {
                let tableName = String(cString: sqlite3_column_text(statement, 0))
                if tableName != "sqlite_sequence" {
                    tables.append(tableName)
                }
            }
        }
        return tables
    }
    
    func tableExists(tableName: String) -> Bool {
        let tables = getTables()
        if tables.contains(tableName) {
            return true
        }
        return false
    }
    
    func getNumberOfRecords(whereClause: String?) -> Any {
        var statement: OpaquePointer?
        var cmd = "SELECT count() FROM \(tableName)"
        if whereClause != nil, whereClause?.count ?? 0 > 0 {
            cmd += " WHERE \(parseWhereClauseWithGrammar(whereClause!))"
        }
        if sqlite3_prepare(dbInstance, cmd, -1, &statement, nil) != SQLITE_OK {
            sqlite3_finalize(statement)
            let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
            return Fault(message: errorMessage)
        }
        while(sqlite3_step(statement) == SQLITE_ROW) {
            let count = sqlite3_column_int(statement, 0)
            sqlite3_finalize(statement)
            return Int(count)
        }
        return 0
    }
    
    func dropTable() {
        let cmd = "DROP TABLE IF EXISTS \(tableName)"
        sqlite3_exec(dbInstance, cmd, nil, nil, nil)
    }
    
    // this method is called only in the func initLocalDatabase(whereClause: String, responseHandler: (() -> Void)!, errorHandler: ((Fault) -> Void)!)
    func initInsert(object: [String : Any], errorHandler: ((Fault) -> Void)!) {
        let cmd = prepareInsertCommand(object: object)
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) != SQLITE_OK || sqlite3_step(statement) != SQLITE_DONE {
            let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
            errorHandler(Fault(message: errorMessage))
        }
    }
    
    func insert(object: [String : Any]) -> Int? {
        let cmd = prepareInsertCommand(object: object)
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK, sqlite3_step(statement) == SQLITE_DONE {
            return Int(sqlite3_last_insert_rowid(dbInstance))
        }
        //⚠️⚠️⚠️⚠️⚠️ else { let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance)) }
        return nil
    }
    
    func update(newValues: [String : Any], whereClause: String) {
        let existingColumns = getColumns()
        var valuesString = ""
        for (key, value) in newValues {
            if !existingColumns.keys.contains(key), !(value is NSNull) {
                addColumn(columnName: key, columnType: getFieldType(value: value))
            }
            if key != "___class" {
                if value is String {
                    valuesString += "\(key) = '\(value)', "
                }
                else if !(value is NSNull) {
                    valuesString += "\(key) = \(value), "
                }
            }
        }
        valuesString = String(valuesString.dropLast(2))
        let cmd = "UPDATE \(tableName) SET \(valuesString) WHERE blPendingOperation != \(BlPendingOperation.delete.rawValue) AND \(parseWhereClauseWithGrammar(whereClause))"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK, sqlite3_step(statement) == SQLITE_DONE {
        }
    }
    
    func removeLocally(whereClause: String) {
        let cmd = "DELETE FROM \(tableName) WHERE \(parseWhereClauseWithGrammar(whereClause))"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                // ⚠️⚠️⚠️⚠️⚠️ let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
            }
        }
        else {
            // ⚠️⚠️⚠️⚠️⚠️ let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
        }
        sqlite3_finalize(statement)
    }
    
    func select(whereClause: String) -> Any {
        return select(properties: nil, whereClause: whereClause, limit: nil, offset: nil, orderBy: nil, groupBy: nil, having: nil)
    }
    
    func select(properties: [String]?, whereClause: String?, limit: Int?, offset: Int?, orderBy: [String]?, groupBy: [String]?, having: String?) -> Any {
        var resultArray = [[String : Any]]()
        var props = properties
        if props == nil { props = ["*"] }
        let columnList = dataTypesUtils.arrayToString(array: props!)
        var cmd = "SELECT \(columnList) FROM \(tableName) WHERE blPendingOperation != \(BlPendingOperation.delete.rawValue)"
        if whereClause != nil {
            cmd += " AND \(parseWhereClauseWithGrammar(whereClause!))"
        }
        if orderBy != nil {
            let orderByString = dataTypesUtils.arrayToString(array: orderBy!)
            cmd += " ORDER BY \(orderByString)"
        }
        if groupBy != nil {
            let groupByString = dataTypesUtils.arrayToString(array: groupBy!)
            cmd += " GROUP BY \(groupByString)"
        }
        if having != nil {
            cmd += " HAVING \(parseWhereClauseWithGrammar(having!))"
        }
        if limit != nil {
            cmd += " LIMIT \(limit!)"
        }
        if offset != nil {
            cmd += " OFFSET \(offset!)"
        }
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
            return Fault(message: errorMessage, faultCode: 0)
        }
        let tableColumns = getColumns()
        while(sqlite3_step(statement) == SQLITE_ROW) {
            var object = [String : Any]()
            for i in 0..<tableColumns.count {
                if let currentColumn = sqlite3_column_name(statement, Int32(i)) {
                    let columnName = String(cString: currentColumn)
                    if columnName != "blPendingOperation", columnName != "blLocalTimestamp" {
                        if columnName == "blLocalId" || columnName == "created" || columnName == "updated" {
                            let intValue = sqlite3_column_int64(statement, Int32(i))
                            if columnName == "blLocalId" || (columnName == "created" && intValue > 0) || (columnName == "updated" && intValue > 0) {
                                object[columnName] = intValue
                            }
                        }
                        else if columnName == "objectId" || columnName == "ownerId" {
                            if let stringValue = sqlite3_column_text(statement, Int32(i)) {
                                object[columnName] = String(cString: stringValue)
                            }
                        }
                        else {
                            let columnType = tableColumns[columnName]
                            if columnType == "INTEGER" {
                                let intValue = sqlite3_column_int64(statement, Int32(i))
                                object[columnName] = intValue
                            }
                            else if columnType == "REAL" {
                                let doubleValue = sqlite3_column_double(statement, Int32(i))
                                object[columnName] = doubleValue
                            }
                            else if columnType == "TEXT" {
                                if let stringValue = sqlite3_column_text(statement, Int32(i)) {
                                    object[columnName] = String(cString: stringValue)
                                }
                            }
                        }
                    }
                }
            }
            resultArray.append(object)
        }
        sqlite3_finalize(statement)
        return resultArray
    }
    
    // ***************************************************************
    
    /*public func insert(object: [String : Any], needTransaction: Bool) {
        let blLocalTimestamp = dataTypesUtils.dateToInt(date: Date())
        let blPendingOperation = BlPendingOperation.create.rawValue
        var cmd = "INSERT INTO \(tableName) (blLocalTimestamp, blPendingOperation, objectId, ownerId, created, updated"
        for key in object.keys {
            if key != "blLocalTimestamp", key != "blLocalTimestamp", key != "objectId", key != "ownerId", key != "created", key != "updated", key != "___class", !(object[key] is NSNull) {
                cmd += ", \(key)"
            }
        }
        cmd += ") VALUES (\(blLocalTimestamp), \(blPendingOperation)"
        if let objectId = object["objectId"] as? String {
            cmd += ", '\(objectId)'"
        }
        else {
            cmd += ", null"
        }
        if let ownerId = object["ownerId"] as? String {
            cmd += ", '\(ownerId)'"
        }
        else {
            cmd += ", null"
        }
        if let created = object["created"] as? NSNumber {
            cmd += ", \(created)"
        }
        else {
            //cmd += ", null"
            cmd += ", \(blLocalTimestamp)"
        }
        if let updated = object["updated"] as? NSNumber {
            cmd += ", \(updated)"
        }
        else {
            cmd += ", null"
        }
        let existingColumns = getTableColumns()
        for (key, value) in object {
            if key != "blLocalTimestamp", key != "blLocalTimestamp", key != "objectId", key != "ownerId", key != "created", key != "updated", key != "___class", !(value is NSNull) {
                if value is Date {
                    cmd += ", \(dataTypesUtils.dateToInt(date: value as! Date))"
                }
                else if value is Bool {
                    if value as! Bool == true {
                        cmd += ", 1"
                    }
                    else {
                        cmd += ", 0"
                    }
                }
                else if value is String {
                    cmd += ", '\(value)'"
                }
                else {
                    cmd += ", \(value)"
                }
                if !existingColumns.keys.contains(key) {
                    addColumn(columnName: key, columnType: getFieldType(value: value))
                }
            }
        }
        cmd += ")"
        var statement: OpaquePointer?
        let semaphore = DispatchSemaphore(value: 0)
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK, sqlite3_step(statement) == SQLITE_DONE {
            if needTransaction {
                let insertedObject = getLastInsertedObject()
                let transaction = Transaction(tableName: tableName, object: insertedObject)
                transactionsManager.saveTransaction(transaction: transaction)
                if connectionManager.deviceIsOnline && (Backendless.shared.data.isAutoSyncEnabled || connectionManager.autoSyncTables.contains(tableName)) {
                    
                    // ⚠️ get properties here, maybe object has a bool prop!
                    
                    let objectToSave = localUtils.removeLocalAndGetMappedProperties(tableName: self.tableName, entity: insertedObject)
                    
                    // *********************************************
//                    let res = PersistenceServiceUtils().checkPropertiesForSync(tableName: self.tableName, dictionary: objectToSave)
//                    for (key, val) in res {
//                        print("🔶 \(key): \(val)")
//                    }
                    
                    // *********************************************
                    
                    
                    
                    DispatchQueue.global().async {
                        Backendless.shared.data.ofTable(self.connectionManager.getMappedNameFor(tableName: self.tableName)).save(entity: objectToSave, responseHandler: { savedRemotely in
                            self.transactionsManager.removeTransaction(transaction: transaction)
                            let blLocalId = insertedObject["blLocalId"] as! NSNumber
                            let objectId = savedRemotely["objectId"] as! String
                            let created = savedRemotely["created"] as! NSNumber
                            self.update(newValues: ["blPendingOperation": BlPendingOperation.none.rawValue, "objectId": objectId, "created": created], whereClause: "blLocalId = \(blLocalId)", needTransaction: false)
                            var savedResponse = savedRemotely
                            savedResponse["blLocalId"] = blLocalId
                            self.callbacksManager.onSaveCallbacks[self.tableName]?(savedResponse)
                            semaphore.signal()
                        }, errorHandler: { fault in
                            self.callbacksManager.onSaveErrorCallbacks[self.tableName]?(fault)
                            semaphore.signal()
                        })
                    }
                }
                else {
                    semaphore.signal()
                }
            }
            else {
                semaphore.signal()
            }
        }
        else {
            let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
            let fault = Fault(message: errorMessage, faultCode: 0)
            self.callbacksManager.onSaveErrorCallbacks[self.tableName]?(fault)
            semaphore.signal()
        }
        semaphore.wait()
        return
    }
    
    func update(newValues: [String : Any], whereClause: String, needTransaction: Bool) {
        let existingColumns = getTableColumns()
        var valuesString = ""
        for (key, value) in newValues {
            if !existingColumns.keys.contains(key), !(value is NSNull) {
                addColumn(columnName: key, columnType: getFieldType(value: value))
            }
            if key != "___class" {
                if value is String {
                    valuesString += "\(key) = '\(value)', "
                }
                else if !(value is NSNull) {
                    valuesString += "\(key) = \(value), "
                }
            }
        }
        valuesString = String(valuesString.dropLast(2))
        let cmd = "UPDATE \(tableName) SET \(valuesString) WHERE blPendingOperation != \(BlPendingOperation.delete.rawValue) AND \(parseWhereClauseWithGrammar(whereClause))"
        var statement: OpaquePointer?
        let semaphore = DispatchSemaphore(value: 0)
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                if needTransaction {
                    var updatedObject = newValues
                    if let objectId = updatedObject["objectId"] as? String,
                        let localObjects = select(properties: ["*"], whereClause: "objectId = '\(objectId)'", limit: nil, offset: nil, orderBy: nil, groupBy: nil, having: nil) as? [[String : Any]],
                        let localObject = localObjects.first {
                        updatedObject["blLocalId"] = localObject["blLocalId"]
                        updatedObject["blPendingOperation"] = BlPendingOperation.update.rawValue
                        if let updated = updatedObject["updated"] {
                            updatedObject["blLocalTimestamp"] = updated
                        }
                        else if let created = updatedObject["created"] {
                            updatedObject["blLocalTimestamp"] = created
                        }
                    }
                    else if let blLocalId = updatedObject["blLocalId"] as? NSNumber,
                        let localObjects = select(properties: ["*"], whereClause: "blLocalId = \(blLocalId)", limit: nil, offset: nil, orderBy: nil, groupBy: nil, having: nil) as? [[String : Any]], localObjects.first != nil {
                        updatedObject["blPendingOperation"] = BlPendingOperation.update.rawValue
                        if let updated = updatedObject["updated"] as? NSNumber, updated > 0 {
                            updatedObject["blLocalTimestamp"] = updated
                        }
                        else if let created = updatedObject["created"] as? NSNumber, created > 0 {
                            updatedObject["blLocalTimestamp"] = created
                        }
                        else {
                            updatedObject["blLocalTimestamp"] = dataTypesUtils.dateToInt(date: Date())
                        }
                    }
                    let transaction = Transaction(tableName: tableName, object: updatedObject)
                    transactionsManager.saveTransaction(transaction: transaction)
                    if connectionManager.deviceIsOnline && (Backendless.shared.data.isAutoSyncEnabled || connectionManager.autoSyncTables.contains(tableName)) {
                        let objectToUpdate = localUtils.removeLocalAndGetMappedProperties(tableName: self.tableName, entity: newValues)
                        DispatchQueue.global().async {
                            Backendless.shared.data.ofTable(self.connectionManager.getMappedNameFor(tableName: self.tableName)).update(entity: objectToUpdate, responseHandler: { updatedRemotely in
                                self.transactionsManager.removeTransaction(transaction: transaction)
                                var updatedResponse = updatedRemotely
                                updatedResponse["blLocalId"] = objectToUpdate["blLocalId"]
                                self.callbacksManager.onSaveCallbacks[self.tableName]?(updatedResponse)
                                semaphore.signal()
                            }, errorHandler: { fault in
                                self.callbacksManager.onSaveErrorCallbacks[self.tableName]?(fault)
                            })
                        }
                    }
                        // device is offline
                    else {
                        semaphore.signal()
                    }
                }
                    // needTransaction = false
                else {
                    semaphore.signal()
                }
            }
                // an error occured
            else {
                let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
                let fault = Fault(message: errorMessage, faultCode: 0)
                self.callbacksManager.onSaveErrorCallbacks[self.tableName]?(fault)
                semaphore.signal()
            }
        }
        else {
            let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
            let fault = Fault(message: errorMessage, faultCode: 0)
            self.callbacksManager.onSaveErrorCallbacks[self.tableName]?(fault)
            semaphore.signal()
        }
        semaphore.wait()
        return
    }
    
    func remove(entity: [String : Any], needTransaction: Bool) {
        var whereClause = ""
        if let objectId = entity["objectId"] as? String {
            whereClause += "objectId = '\(objectId)'"
        }
        else if let blLocalId = entity["blLocalId"] as? NSNumber {
            // remove only offline because it doesn't exist online
            self.removeLocally(whereClause: "blLocalId = \(blLocalId)")
            // also remove all transactions with this object
            let transactions = transactionsManager.getTransactions()
            let transactionsToRemove = transactions.filter({ $0.object["blLocalId"] as? NSNumber == blLocalId })
            for transactionToRemove in transactionsToRemove {
                transactionsManager.removeTransaction(transaction: transactionToRemove)
            }
            return
        }
        var objectToRemove = entity
        objectToRemove["blPendingOperation"] = BlPendingOperation.delete.rawValue
        update(newValues: objectToRemove, whereClause: whereClause, needTransaction: false)
        if needTransaction {
            let transaction = Transaction(tableName: tableName, object: objectToRemove)
            transactionsManager.saveTransaction(transaction: transaction)
            let semaphore = DispatchSemaphore(value: 0)
            if connectionManager.deviceIsOnline && (Backendless.shared.data.isAutoSyncEnabled || connectionManager.autoSyncTables.contains(tableName)) {
                DispatchQueue.global().async {
                    if let objectId = objectToRemove["objectId"] as? String {
                        Backendless.shared.data.ofTable(self.tableName).removeById(objectId: objectId, responseHandler: { removedRemotely in
                            objectToRemove.removeValue(forKey: "blLocalTimestamp")
                            objectToRemove.removeValue(forKey: "blPendingOperation")
                            self.callbacksManager.onRemoveCallbacks[self.tableName]?(objectToRemove)
                            self.removeLocally(whereClause: "objectId = '\(objectId)'")
                            semaphore.signal()
                        }, errorHandler: { fault in
                            self.callbacksManager.onRemoveErrorCallbacks[self.tableName]?(fault)
                            semaphore.signal()
                        })
                    }
                }
            }
            else {
                semaphore.signal()
            }
            semaphore.wait()
            return
        }
    }
    
    func removeLocally(whereClause: String) {
        let cmd = "DELETE FROM \(tableName) WHERE \(parseWhereClauseWithGrammar(whereClause))"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
                let fault = Fault(message: errorMessage, faultCode: 0)
                self.callbacksManager.onRemoveErrorCallbacks[self.tableName]?(fault)
            }
        }
        else {
            let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
            let fault = Fault(message: errorMessage, faultCode: 0)
            self.callbacksManager.onRemoveErrorCallbacks[self.tableName]?(fault)
        }
        sqlite3_finalize(statement)
    }
    
    public func select(properties: [String], whereClause: String?, limit: Int?, offset: Int?, orderBy: [String]?, groupBy: [String]?, having: String?) -> Any {
        var resultArray = [[String : Any]]()
        let columnList = dataTypesUtils.arrayToString(array: properties)
        var cmd = "SELECT \(columnList) FROM \(tableName) WHERE blPendingOperation != \(BlPendingOperation.delete.rawValue)"
        if whereClause != nil {
            cmd += " AND \(parseWhereClauseWithGrammar(whereClause!))"
        }
        if orderBy != nil {
            let orderByString = dataTypesUtils.arrayToString(array: orderBy!)
            cmd += " ORDER BY \(orderByString)"
        }
        if groupBy != nil {
            let groupByString = dataTypesUtils.arrayToString(array: groupBy!)
            cmd += " GROUP BY \(groupByString)"
        }
        if having != nil {
            cmd += " HAVING \(parseWhereClauseWithGrammar(having!))"
        }
        if limit != nil {
            cmd += " LIMIT \(limit!)"
        }
        if offset != nil {
            cmd += " OFFSET \(offset!)"
        }
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
            return Fault(message: errorMessage, faultCode: 0)
        }
        let tableColumns = getTableColumns()
        while(sqlite3_step(statement) == SQLITE_ROW) {
            var object = [String : Any]()
            for i in 0..<tableColumns.count {
                if let currentColumn = sqlite3_column_name(statement, Int32(i)) {
                    let columnName = String(cString: currentColumn)
                    if columnName != "blPendingOperation", columnName != "blLocalTimestamp" {
                        if columnName == "blLocalId" || columnName == "created" || columnName == "updated" {
                            let intValue = sqlite3_column_int64(statement, Int32(i))
                            if columnName == "blLocalId" || (columnName == "created" && intValue > 0) || (columnName == "updated" && intValue > 0) {
                                object[columnName] = intValue
                            }
                        }
                        else if columnName == "objectId" || columnName == "ownerId" {
                            if let stringValue = sqlite3_column_text(statement, Int32(i)) {
                                object[columnName] = String(cString: stringValue)
                            }
                        }
                        else {
                            let columnType = tableColumns[columnName]
                            if columnType == "INTEGER" {
                                let intValue = sqlite3_column_int64(statement, Int32(i))
                                object[columnName] = intValue
                            }
                            else if columnType == "REAL" {
                                let doubleValue = sqlite3_column_double(statement, Int32(i))
                                object[columnName] = doubleValue
                            }
                            else if columnType == "TEXT" {
                                if let stringValue = sqlite3_column_text(statement, Int32(i)) {
                                    object[columnName] = String(cString: stringValue)
                                }
                            }
                        }
                    }
                }
            }
            resultArray.append(object)
        }
        sqlite3_finalize(statement)
        return resultArray
    }
    
    // ************************
     
    func recordExists(whereClause: String) -> Bool {
        if let selectedRecords = select(properties: ["*"], whereClause: parseWhereClauseWithGrammar(whereClause), limit: nil, offset: nil, orderBy: nil, groupBy: nil, having: nil) as? [[String : Any]], selectedRecords.first != nil {
            return true
        }
        return false
    }
    
    
    private func getLastInsertedObject() -> [String : Any] {
        var object = [String : Any]()
        let cmd = "SELECT * FROM \(tableName) ORDER BY blLocalId DESC LIMIT 1"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK {
            let tableColumns = getTableColumns()
            while(sqlite3_step(statement) == SQLITE_ROW) {
                for i in 0..<tableColumns.count {
                    if let currentColumn = sqlite3_column_name(statement, Int32(i)) {
                        let columnName = String(cString: currentColumn)
                        if tableColumns[columnName] == "INTEGER" {
                            let intValue = sqlite3_column_int64(statement, Int32(i))
                            if (columnName == "created" || columnName == "updated") && intValue == 0 {
                                object[columnName] = nil
                            }
                            else {
                                object[columnName] = intValue
                            }
                        }
                        else if tableColumns[columnName] == "REAL" {
                            object[columnName] = sqlite3_column_double(statement, Int32(i))
                        }
                        else if tableColumns[columnName] == "TEXT",
                            let textValue = sqlite3_column_text(statement, Int32(i)) {
                            object[columnName] = String(cString: textValue)
                        }
                    }
                }
            }
        }
        return object
    }
    
    */
}
