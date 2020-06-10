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

class LocalManager {
    
    static let shared = LocalManager()
    
    private let SQLITE_TRANSIENT = unsafeBitCast(OpaquePointer(bitPattern: -1), to: sqlite3_destructor_type.self)
    
    private var dbInstance: OpaquePointer?
    private var dbUrl: URL!
    private var dbOpened = false
    
    // MARK: - Init
    
    private init() {
        dbUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("myDB.sqlite")
        openDB()
    }
    
    deinit {
        closeDB()
    }
    
    // MARK: - Internal functions
    
    func createTableIfNotExist(_ tableName: String) {
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
    
    func tableExists(_ tableName: String) -> Bool {
        if getTables().contains(tableName) {
            return true
        }
        return false
    }
    
    func getNumberOfRecords(_ tableName: String, whereClause: String?) -> Any {
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
    
    func recordExists(tableName: String, whereClause: String) -> Bool {
        if let selectedRecords = select(tableName: tableName, withDeleted: false, properties: ["*"], whereClause: parseWhereClauseWithGrammar(whereClause), limit: nil, offset: nil, orderBy: nil, groupBy: nil, having: nil) as? [[String : Any]], selectedRecords.first != nil {
            return true
        }
        return false
    }
    
    func dropTable(_ tableName: String) {
        let cmd = "DROP TABLE IF EXISTS \(tableName)"
        sqlite3_exec(dbInstance, cmd, nil, nil, nil)
    }
    
    // this method is called only in the func initLocalDatabase(whereClause: String, responseHandler: (() -> Void)!, errorHandler: ((Fault) -> Void)!)
    func initInsert(tableName: String, object: [String : Any], errorHandler: ((Fault) -> Void)!) {
        createTableIfNotExist(tableName)
        let cmd = prepareInsertCommand(tableName: tableName, object: object, blPendingOperation: BlPendingOperation.none.rawValue)
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) != SQLITE_OK || sqlite3_step(statement) != SQLITE_DONE {
            let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
            errorHandler(Fault(message: errorMessage))
        }
    }
    
    func insert(tableName: String, object: [String : Any], blPendingOperation: BlPendingOperation, localResponseHandler: ((Any) -> Void)?, localErrorHandler: ((Fault) -> Void)?) {
        createTableIfNotExist(tableName)
        let object = PersistenceLocalHelper.shared.prepareGeometryForOffline(object)
        let cmd = prepareInsertCommand(tableName: tableName, object: object, blPendingOperation: blPendingOperation.rawValue)
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK, sqlite3_step(statement) == SQLITE_DONE {
            let blLocalId = Int(sqlite3_last_insert_rowid(dbInstance))
            if let insertedObject = (select(tableName: tableName, whereClause: "blLocalId=\(blLocalId)") as? [[String : Any]])?.first {
                localResponseHandler?(insertedObject)
            }
        }
        else {
            let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
            let fault = Fault(message: errorMessage)
            localErrorHandler?(fault)
        }
    }
    
    func update(tableName: String, newValues: [String : Any], whereClause: String, blPendingOperation: BlPendingOperation, localResponseHandler: ((Any) -> Void)?, localErrorHandler: ((Fault) -> Void)?) {
        let newValues = PersistenceLocalHelper.shared.prepareGeometryForOffline(newValues)
        var valuesString = ""
        for (key, value) in newValues {
            if !getColumns(tableName).keys.contains(key), !(value is NSNull) {
                addColumn(tableName: tableName, columnName: key, columnType: getFieldType(value: value))
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
        valuesString += "blPendingOperation = \(blPendingOperation.rawValue)"
        let cmd = "UPDATE \(tableName) SET \(valuesString) WHERE blPendingOperation != \(BlPendingOperation.delete.rawValue) AND \(parseWhereClauseWithGrammar(whereClause))"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK, sqlite3_step(statement) == SQLITE_DONE {
            let result = select(tableName: tableName, whereClause: whereClause)
            if result is [[String : Any]],
                let updatedObject = (result as! [[String : Any]]).first {
                localResponseHandler?(updatedObject)
            }
            else if result is Fault {
                localErrorHandler?(result as! Fault)
            }
            else {
                // ⚠️ result not found because it is prepared for deleting
                let result = select(tableName: tableName, withDeleted: true, properties: nil, whereClause: whereClause, limit: nil, offset: nil, orderBy: nil, groupBy: nil, having: nil)
                if result is [[String : Any]],
                    let updatedObject = (result as! [[String : Any]]).first {
                    localResponseHandler?(updatedObject)
                }
            }
        }
        else {
            let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
            let fault = Fault(message: errorMessage)
            localErrorHandler?(fault)
        }
    }
    
    func delete(tableName: String, whereClause: String, localResponseHandler: ((Any) -> Void)?, localErrorHandler: ((Fault) -> Void)?) {
        let result = select(tableName: tableName, whereClause: whereClause)
        if result is [[String : Any]],
            let deletedObject = (result as! [[String : Any]]).first {
            let cmd = "DELETE FROM \(tableName) WHERE \(parseWhereClauseWithGrammar(whereClause))"
            var statement: OpaquePointer?
            if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK, sqlite3_step(statement) == SQLITE_DONE {
                localResponseHandler?(deletedObject)
            }
            else {
                let errorMessage = String.init(cString: sqlite3_errmsg(dbInstance))
                let fault = Fault(message: errorMessage)
                localErrorHandler?(fault)
            }
            sqlite3_finalize(statement)
        }
        else if result is Fault {
            localErrorHandler?(result as! Fault)
        }
    }
    
    func select(tableName: String) -> Any {
        return select(tableName: tableName, withDeleted: false, properties: nil, whereClause: nil, limit: nil, offset: nil, orderBy: nil, groupBy: nil, having: nil)
    }
    
    func select(tableName: String, whereClause: String) -> Any {
        return select(tableName: tableName, withDeleted: false, properties: nil, whereClause: whereClause, limit: nil, offset: nil, orderBy: nil, groupBy: nil, having: nil)
    }
    
    func select(tableName: String, withDeleted: Bool, properties: [String]?, whereClause: String?, limit: Int?, offset: Int?, orderBy: [String]?, groupBy: [String]?, having: String?) -> Any {
        var resultArray = [[String : Any]]()
        if tableExists(tableName) {
            var props = properties
            if props == nil { props = ["*"] }
            let columnList = DataTypesUtils.shared.arrayToString(array: props!)
            var cmd = "SELECT \(columnList) FROM \(tableName)"
            if !withDeleted {
                cmd += " WHERE blPendingOperation != \(BlPendingOperation.delete.rawValue)"
            }
            if whereClause != nil, !whereClause!.isEmpty {
                if !withDeleted {
                    cmd += " AND \(parseWhereClauseWithGrammar(whereClause!))"
                }
                else {
                    cmd += " WHERE \(parseWhereClauseWithGrammar(whereClause!))"
                }
            }
            if orderBy != nil {
                let orderByString = DataTypesUtils.shared.arrayToString(array: orderBy!)
                cmd += " ORDER BY \(orderByString)"
            }
            if groupBy != nil {
                let groupByString = DataTypesUtils.shared.arrayToString(array: groupBy!)
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
            let tableColumns = getColumns(tableName)
            while(sqlite3_step(statement) == SQLITE_ROW) {
                var object = [String : Any]()
                for i in 0..<tableColumns.count {
                    if let currentColumn = sqlite3_column_name(statement, Int32(i)) {
                        let columnName = String(cString: currentColumn)
                        if columnName == "blLocalId" || columnName == "blPendingOperation" ||
                            columnName == "created" || columnName == "updated" || columnName == "blLocalTimestamp" {
                            let intValue = sqlite3_column_int64(statement, Int32(i))
                            object[columnName] = intValue
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
                resultArray.append(object)
            }
            sqlite3_finalize(statement)
        }
        return resultArray
    }
    
    // MARK: - Private functions
    
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
    
    private func addColumn(tableName: String, columnName: String, columnType: String) {
        let cmd = "ALTER TABLE \(tableName) ADD COLUMN \(columnName) \(columnType)"
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(dbInstance, cmd, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
            }
        }
        sqlite3_finalize(statement)
    }
    
    private func getColumns(_ tableName: String) -> [String : String] {
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
    
    private func getFieldType(value: Any) -> String {
        var fieldType = "REAL"
        if value is NSInteger {
            fieldType = "INTEGER"
        }
        else if value is String {
            fieldType = "TEXT"
        }
        else if value is BLGeometry {
            fieldType = "STRING"
        }
        return fieldType
    }
    
    private func prepareInsertCommand(tableName: String, object: [String : Any], blPendingOperation: Int) -> String {
        var blLocalTimestamp = 0
        if let updated = object["updated"] as? Int {
            blLocalTimestamp = updated
        }
        else if let created = object["created"] as? Int {
            blLocalTimestamp = created
        }
        else {
            blLocalTimestamp = DataTypesUtils.shared.dateToInt(date: Date())
        }
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
        for (key, value) in object {
            if key != "blLocalTimestamp", key != "blLocalTimestamp", key != "objectId", key != "ownerId", key != "created", key != "updated", key != "___class", !(value is NSNull) {
                if value is Date {
                    cmd += ", \(DataTypesUtils.shared.dateToInt(date: value as! Date))"
                }
                else if value is Bool {
                    if value as! Bool == true {
                        cmd += ", 1"
                    }
                    else {
                        cmd += ", 0"
                    }
                }
                else if value is BLGeometry, let wkt = (value as! BLGeometry).asWkt() {
                    cmd += ", \(wkt)"
                }
                else if value is String {
                    cmd += ", '\(value)'"
                }
                else {
                    cmd += ", \(value)"
                }
                if !getColumns(tableName).keys.contains(key) {
                    addColumn(tableName: tableName, columnName: key, columnType: getFieldType(value: value))
                }
            }
        }
        cmd += ")"
        return cmd
    }
}