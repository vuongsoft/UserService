//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 17/08/2021.
//

import Vapor
import Fluent

final class Rating: Model, Content {
    static let schema = Rating.v102.schemaName
    
    @ID(key: .id)
    var id: UUID?
    
    @OptionalField(key: Rating.v102.content)
    var content: String?
    
    @Field(key: Rating.v102.point)
    var point: Int
    
    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deletedAt", on: .delete)
    var deletedAt: Date?
    
    @Parent(key: Rating.v102.user_id)
    var user: User
    
    init() {
    }
    
    init(id: UUID? = nil, content: String? = nil, point: Int, user_id: User.IDValue) {
        self.id = id
        self.content = content
        self.point = point
        self.$user.id = user_id
    }
}
