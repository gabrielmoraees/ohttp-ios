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
public func authorizedRequest(method: HTTPMethod, _ URLString: URLConvertible, parameters: [String: Any]? = nil, encoding: URLEncoding = URLEncoding.default, headers: [String: String]? = nil) -> DataRequest {
    Alamofire.request(URLString).response { (response) in
        
    }
    return SessionManager.default.authorizedRequest(method: method, URLString, parameters: parameters, encoding: encoding, headers: headers)
}


/*
 
 */
public extension Alamofire.DataRequest {
    
    typealias CompletionHandler = (DefaultDataResponse) -> Void
    
    public func authorize(completionHandler: @escaping CompletionHandler) -> Self {
        return authorizationHandler(nil, completionHandler: completionHandler)
    }
    
    public func authorize() -> Self {
        return authorizationHandler(nil, completionHandler: nil)
    }
    
    private func authorizationHandler(_ queue: DispatchQueue? = nil, completionHandler: CompletionHandler?) -> Self {
        
        return response { result in
            if let headers = result.response?.allHeaderFields {
                if let id = headers["x-uid"] as? String {
                    oHTTPEnvironment.x_uid = id
                }
                if let authToken = headers["x-access-token"] as? String {
                    oHTTPEnvironment.currentMutableToken = oHTTPEnvironment.nextMutableToken
                    oHTTPEnvironment.nextMutableToken = authToken
                }
            }
            let dispatchingQueue = queue ?? DispatchQueue.main
            dispatchingQueue.async {
                completionHandler?(result)
            }
        }
    }
    
}

/*
 
 
 */
public extension Alamofire.SessionManager {
    public func authorizedRequest(method: HTTPMethod, _ URLString: URLConvertible, parameters: [String: Any]? = nil, encoding: URLEncoding = URLEncoding.default, headers: [String: String]? = nil) -> DataRequest {
        
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
        
        return self.request(URLString, method: method, parameters: parameters, encoding: encoding, headers: heads)
    }
}
