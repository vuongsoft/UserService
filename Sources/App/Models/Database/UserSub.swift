//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 17/08/2021.
//

import Vapor
import Fluent

final class UserSub: Model, Content {
    static let schema = UserSub.v102.schemaName
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: UserSub.v102.type)
    var type: Int
    
    @Field(key: UserSub.v102.expired)
    var expired: String
    
    @Field(key: UserSub.v102.point)
    var point: Double
    
    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deletedAt", on: .delete)
    var deletedAt: Date?
    
    @Parent(key: UserSub.v102.user_id)
    var user: User
    
    init() {
    }
    
    init(id: UUID? = nil, type: Int, expired: String, point: Double, user_id: User.IDValue) {
        self.id = id
        self.type = type
        self.point = point
        self.expired = expired
        self.$user.id = user_id
    }
}
