//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 16/08/2021.
//

import Vapor

struct UserSuccessResponse: Content {
    let status: String = "success"
    let user: User.Public
}
