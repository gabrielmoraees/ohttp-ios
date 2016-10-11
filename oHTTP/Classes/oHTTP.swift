//
//  oHTPP.swift
//  Pods
//
//  Created by Diego Louli on 11/08/16.
//
//

import UIKit
import Alamofire


/*
 
 */
public func authorizedRequest(method: Alamofire.Method, _ URLString: URLStringConvertible, parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = .URL, headers: [String: String]? = nil) -> Request {
    return Manager.sharedInstance.authorizedRequest(method, URLString, parameters: parameters, encoding: encoding, headers: headers)
}


/*
 
 */
public extension Alamofire.Request {
    
    public func authorizedResponse(completionHandler: (NSURLRequest, NSHTTPURLResponse?, NSData?, NSError?) -> Void) -> Self {
        return authorizationHandler(nil, completionHandler: completionHandler)
    }
    
    private func authorizationHandler(queue: dispatch_queue_t? = nil, completionHandler: (NSURLRequest, NSHTTPURLResponse?, NSData?, NSError?) -> Void) -> Self {
        return response { (req, res, data, error) in
            
            if let headers = res?.allHeaderFields {
                
                if let id = headers["x-uid"] as? String {
                    oHTTPEnvironment.x_uid = id
                }
                
                if let authToken = headers["x-access-token"] as? String {
                    oHTTPEnvironment.currentMutableToken = oHTTPEnvironment.nextMutableToken
                    oHTTPEnvironment.nextMutableToken = authToken
                }
            }
            
            dispatch_async(queue ?? dispatch_get_main_queue(), {
                completionHandler(req!, res, data, error)
            })
        }
    }
}

/*
 
 
 */
public extension Alamofire.Manager {
    public func authorizedRequest(method: Alamofire.Method, _ URLString: URLStringConvertible, parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = .URL, headers: [String: String]? = nil) -> Request {
        
        var heads = headers
        
        if heads == nil {
            heads = [String : String]()
        }
        
        if heads!["authorization"] == nil {
            
            if let authToken = oHTTPEnvironment.nextMutableToken {
                heads!["authorization"] = authToken
            }
        }
        
        if heads!["x-uid"] == nil {
            
            if let uid = oHTTPEnvironment.x_uid {
                heads!["x-uid"] = uid
            }
        }
        
        return self.request(method, URLString, parameters: parameters, encoding: encoding, headers: heads)
    }
}