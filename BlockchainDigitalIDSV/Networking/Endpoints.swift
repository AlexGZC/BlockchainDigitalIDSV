//
//  Endpoints.swift
//  App
//
//  Created by Jonathan Solorzano on 1/22/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

let BASE_URL_DEV = "https://example.com"
let BASE_URL_PROD = "https://example.com"
let BASE_URL = BASE_URL_DEV

/// Endpoints constants to fetch data.
struct Endpoints {
    
    /// Get all users endpoint.
    static let GET_ALL_USERS = "\(BASE_URL)/users/"
}
