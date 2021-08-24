//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 17/08/2021.
//

import Vapor
import Fluent

final class Rating: Model, Content {
    static let schema = Rating.v21082021_102.schemaName
    
    @ID(key: .id)
    var id: UUID?
    
    @OptionalField(key: Rating.v21082021_102.content)
    var content: String?
    
    @Field(key: Rating.v21082021_102.point)
    var point: Int
    
    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deletedAt", on: .delete)
    var deletedAt: Date?
    
    @Field(key: Rating.v21082021_102.rater_id)
    var rater_id: UUID
    
    @Field(key: Rating.v21082021_102.rated_id)
    var rated_id: UUID
    
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
