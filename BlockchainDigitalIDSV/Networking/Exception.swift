//
//  Exception.swift
//  App
//
//  Created by Jonathan Solorzano on 1/22/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation

/// Exception object.
public class Exception: Decodable {
    
    public let message: String
    public let code: String
    
    public init(message: String, code: String) {
        self.message = message
        self.code = code
    }
    
}
