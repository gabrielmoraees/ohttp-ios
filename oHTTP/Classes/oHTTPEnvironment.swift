//
//  oHTTPEnvironment.swift
//  Pods
//
//  Created by Diego Louli on 16/08/16.
//
//

import UIKit

public class oHTTPEnvironment: NSObject {
    
    // MARK:  Controler Variables
    
    static private var _nextMutableToken: String?
    
    /// x-uid
    static public var x_uid: String?
    
    /// Current authorization token
    static public var currentMutableToken: String?
    
    /// Next authorization token
    static public var nextMutableToken: String? {
        
        set (value) {
            _nextMutableToken = value
        }
        
        get {
            
            if let uid = oHTTPEnvironment.x_uid, let token = oHTTPEnvironment._nextMutableToken{
                let authToken = "\(uid):\(token)"
                let authTokenData = authToken.dataUsingEncoding(NSUTF8StringEncoding)
                let authTokenB64 = authTokenData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
                
                return "Bearer \(authTokenB64)"
            } else {
                return nil
            }
        }
    }
}