//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 17/08/2021.
//

import Vapor
import Fluent

final class UserSub: Model, Content {
    static let schema = "usersub"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "type")
    var type: Int
    
    @Field(key: "expired")
    var expired: String
    
    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deletedAt", on: .delete)
    var deletedAt: Date?
    
    @Field(key: "user_id")
    var user_id: UUID
    
    init() {
    }
    
    init(id: UUID? = nil, type: Int, expired: String, user_id: UUID) {
        self.id = id
        self.type = type
        self.expired = expired
        self.user_id = user_id
    }
}
