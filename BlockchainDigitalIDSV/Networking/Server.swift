//
//  Networking.swift
//  DataPagaTestApp
//
//  Created by Jonathan Solorzano on 1/5/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation
import Alamofire

/// Structure for storing server side error messages
struct ErrorResponse: Codable {
    let error: String
}

/// Enum to markup backend response
public enum Response {
    case success(Data)
    case failure(Exception)
}

/// Typealias shortcut for `((DataPagaResponse) -> Void)?`
public typealias RequestCompletion = ((Response) -> Void)?

/// Server wrapper class for handling requests
public class Server {
    
    /// Creates a DataRequest using the default SessionManager to retrieve the contents of the specified url, method, parameters, encoding and headers.
    /// - paramters:
    ///     - endpoint: Endpoint URL
    ///     - method: The HTTP method
    ///     - params: The parameters
    ///     - completionHandler: The request completion handler to execute
    public static func request(_ endpoint: String, method: HTTPMethod, params: Parameters, completionHandler completion: RequestCompletion){
        
        
        Alamofire.request(endpoint, method: method, parameters: params)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON {
            response in
            
            switch response.result {
                
            case .success(_):
                
                guard let jsonData = response.data else {
                    let exception = Exception(message: "No data in response", code: "0")
                    completion?(.failure(exception))
                    return
                }
                
                completion?(.success(jsonData))
                
            case let .failure(error):
                
                let exception = Exception(message: error.localizedDescription, code: "0")
                completion?(.failure(exception))
            }
        }
    }
    
}

