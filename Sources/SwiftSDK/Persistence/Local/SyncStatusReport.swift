//
//  SyncStatusReport.swift
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

@objcMembers public class SyncStatusReport: NSObject {
    
    public var successfulCompletion: SyncSuccess?
    public var failedCompletion: SyncFailure?
    
    public init(successfulCompletion: SyncSuccess?, failedCompletion: SyncFailure?) {
        self.successfulCompletion = successfulCompletion
        self.failedCompletion = failedCompletion
    }
}

@objcMembers public class SyncSuccess: NSObject {
    
    public var created: [Any]?
    public var updated: [Any]?
    public var deleted: [Any]?
    
    public init(created: [Any]?, updated: [Any]?, deleted: [Any]?) {
        self.created = created
        self.updated = updated
        self.deleted = deleted
    }
}

@objcMembers public class SyncFailure: NSObject {
    
    public var createErrors: [SyncError]?
    public var updateErrors: [SyncError]?
    public var deleteErrors: [SyncError]?
    
    public init(createErrors: [SyncError]?, updateErrors: [SyncError]?, deleteErrors: [SyncError]?) {
        self.createErrors = createErrors
        self.updateErrors = updateErrors
        self.deleteErrors = deleteErrors
    }
}

@objcMembers public class SyncError: NSObject {
    public var object: Any?
    public var error: String?
    
    init(object: Any?, error: String?) {
        self.object = object
        self.error = error
    }
}
