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
            
            let authToken = "\(oHTTPEnvironment.x_uid):\(self._nextMutableToken)"
            let authTokenData = authToken.dataUsingEncoding(NSUTF8StringEncoding)
            let authTokenB64 = authTokenData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            
            return "Bearer \(authTokenB64)"
        }
    }
}