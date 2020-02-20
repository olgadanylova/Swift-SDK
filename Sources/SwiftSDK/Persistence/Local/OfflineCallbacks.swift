//
//  OfflineCallbacks.swift
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

@objcMembers public class OfflineAwareCallback: NSObject {
    
    public var localResponseHandler: ((Any) -> Void)?
    public var localErrorHandler: ((Fault) -> Void)?
    public var remoteResponseHandler: ((Any) -> Void)?
    public var remoteErrorHandler: ((Fault) -> Void)?
    
    public init(localResponseHandler: ((Any) -> Void)?, localErrorHandler: ((Fault) -> Void)?, remoteResponseHandler: ((Any) -> Void)?, remoteErrorHandler: ((Fault) -> Void)?) {
        self.localResponseHandler = localResponseHandler
        self.localErrorHandler = localErrorHandler
        self.remoteResponseHandler = remoteResponseHandler
        self.remoteErrorHandler = remoteErrorHandler
    }
}

@objcMembers public class OnSave: NSObject {
    
    public var saveResponseHandler: ((Any) -> Void)?
    public var errorHandler: ((Fault) -> Void)?
    
    public init(saveResponseHandler: ((Any) -> Void)?, errorHandler: ((Fault) -> Void)?) {
        self.saveResponseHandler = saveResponseHandler
        self.errorHandler = errorHandler
    }
}

@objcMembers public class OnRemove: NSObject {
    
    public var removeResponseHandler: ((Any) -> Void)?
    public var errorHandler: ((Fault) -> Void)?
    
    public init(removeResponseHandler: ((Any) -> Void)?, errorHandler: ((Fault) -> Void)?) {
        self.removeResponseHandler = removeResponseHandler
        self.errorHandler = errorHandler
    }
}
