//
//  PersistenceLocalHelper.swift
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

class PersistenceLocalHelper {
    
    static let shared = PersistenceLocalHelper()
    
    private init() { }
    
    func removeLocalTimestampAndPendingOpFields(_ dictionary: [String : Any]) -> [String : Any] {
        var resultDictionary = dictionary
        resultDictionary["blLocalTimestamp"] = nil
        resultDictionary["blPendingOperation"] = nil
        return resultDictionary
    }
    
    func removeAllLocalFields(_ dictionary: [String : Any]) -> [String : Any] {
        var resultDictionary = dictionary
        resultDictionary["blLocalId"] = nil
        resultDictionary["blLocalTimestamp"] = nil
        resultDictionary["blPendingOperation"] = nil
        return resultDictionary
    }
    
    func prepareGeometryForOffline(_ dictionary: [String : Any]) -> [String : Any] {
        var resultDictionary = dictionary
        for (key, value) in resultDictionary {
            if value is BLGeometry {
                resultDictionary[key] = (value as! BLGeometry).asWkt()
            }
        }     
        return resultDictionary
    }
    
    func prepareOfflineObjectForResponse(_ dictionary: [String : Any]) -> [String : Any] {
        var resultDictionary = dictionary
        for (key, value) in resultDictionary {
            if let stringValue = value as? String {
                if stringValue.contains(BLPoint.wktType), let point = try? BLPoint.fromWkt(stringValue) {
                    resultDictionary[key] = point
                }
                else if stringValue.contains(BLLineString.wktType), let lineString = try? BLLineString.fromWkt(stringValue) {
                    resultDictionary[key] = lineString
                }
                else if stringValue.contains(BLPolygon.wktType), let polygon = try? BLPolygon.fromWkt(stringValue) {
                    resultDictionary[key] = polygon
                }
            }
        }
        return resultDictionary
    }
}
