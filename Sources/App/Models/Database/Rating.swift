//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 17/08/2021.
//

import Vapor
import Fluent

final class Rating: Model, Content {
    static let schema = "rating"
    
    @ID(key: .id)
    var id: UUID?
    
    @OptionalField(key: "content")
    var content: String?
    
    @Field(key: "point")
    var point: Int
    
    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deletedAt", on: .delete)
    var deletedAt: Date?
    
    @Field(key: "rater_id")
    var user_id: UUID
    
    @Field(key: "rated_id")
    var raterID: UUID
    
    init() {
    }
    
    init(id: UUID? = nil, content: String? = nil, point: Int, rater_id: UUID, rated_id: UUID) {
        self.id = id
        self.content = content
        self.point = point
        self.rater_id = rater_id
        self.rated_id = rated_id
    }
}
