//
//  ConnectionManager.swift
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

import SystemConfiguration

class ConnectionManager {
    
    private var reachability: Reachability? = try? Reachability()
    
    init() {
        configure()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        reachability?.stopNotifier()
    }
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func observeReachability(){
        self.reachability = try? Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability(notification:)), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability?.startNotifier()
        }
        catch(let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }
    
    private func configure() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.checkForReachability(notification:)),
                                               name: Notification.Name.reachabilityChanged,
                                               object: nil)
        try? reachability?.startNotifier()
        
    }
    
    @objc private func checkForReachability(notification: NSNotification) {
        let networkReachability = notification.object as? Reachability
        if let remoteHostStatus = networkReachability?.connection {
            switch remoteHostStatus {
            case .none, .unavailable:
                print("")
            case .wifi, .cellular:
                print("🟢")
                // if offlineSync enabled
                // check what tables to sync
                // select all where pendingOp != .none
                // process
            }
        }
    }
}
