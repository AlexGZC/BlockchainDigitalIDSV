//
//  Router.swift
//  App
//
//  Created by alex on 12/20/17.
//  Copyright © 2017 alexcontreras. All rights reserved.
//

import Foundation
import Alamofire



enum Router: URLRequestConvertible{
    
   
    
    static let baseURLString = "http://192.168.137.219/digitalidsv/api.php?mode="

    case getsomething()
    case postsomething([String: Any])
    
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            switch self {

            case .getsomething:
                return .get
            case .postsomething(_):
                return .post
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {

            case .getsomething:
                return nil
            case .postsomething(let params):
                return (params)
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self {

            case .getsomething:
                relativePath = "get/path"
            case .postsomething(_):
                relativePath = "users&id=register"
            }
            var url = URL(string: Router.baseURLString)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
}


