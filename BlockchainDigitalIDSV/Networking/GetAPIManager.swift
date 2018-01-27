//
//  Data.swift
//  Papajohns
//
//  Created by alex on 10/17/17.
//  Copyright © 2017 elaniin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetAPIManager: NSObject{
    enum BackendError: Error {
        case urlError(reason: String)
        case objectSerialization(reason: String)
    }
    
    class func Get(_ strURL: URLRequest, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            
            //print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                
                
                
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    
    class func Post(_ strURL : String, params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
       Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseString { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    class func Post2(_ strURL : String, params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
                
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
}



