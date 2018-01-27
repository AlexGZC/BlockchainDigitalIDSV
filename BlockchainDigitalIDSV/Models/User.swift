//
//  User.swift
//  App
//
//  Created by Jonathan Solorzano on 1/22/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

struct User {
    
    let username: String
    let password: String
    
    var loginUser:[String:AnyObject] {
        get {
            return ["username" : username,
                    "password" : password] as [String : AnyObject]
        }
    }
}

struct UserAdmin {
    
    let email: String
    let password: String
    
    var loginUser:[String:AnyObject] {
        get {
            return ["email" : email,
                    "password" : password] as [String : AnyObject]
        }
    }
}

struct AddUserParameters {
    let username: String
    let password: String
    let phone: String
    
    var getUser:[String:AnyObject] {
        get {
            return ["username" : username,
                    "password" : password,
                    "phone" : phone] as [String : AnyObject]
        }
    }
    
}

struct LoginIsSuccessfull {
    let secure_code: String
    let type: String
    let name: String
    let lastname: String
    let gender: String
    let birthdate: String
    
    
    var sendFragement1:[String:AnyObject] {
        get {
            return ["secure_code" : secure_code,
                    "type" : type,
                    "name" : name,
                    "lastname": lastname ,
                    "gender":gender,
                    "birthdate": birthdate
                    ] as [String : AnyObject]
        }
    }
}



struct defaultsKeys {
    static var token = "screen1"
    static var securecode = "securecode"
    
}

