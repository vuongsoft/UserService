//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 17/08/2021.
//

import Fluent

struct CreateRating: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(Rating.v102.schemaName)
        .id()
        .field(Rating.v102.content, .string)
        .field(Rating.v102.point, .int, .required)
        .field("createdAt", .datetime)
        .field("updatedAt", .datetime)
        .field("deletedAt", .datetime)
        .field(Rating.v102.user_id, .uuid, .required, .references(User.v102.schemaName, User.v102.id))
        .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(Rating.v102.schemaName).delete()
  }
}

extension Rating {
    enum v102 {
    static let schemaName = "rating"
        
    static let id = FieldKey(stringLiteral: "id")
    static let content = FieldKey(stringLiteral: "content")
    static let point = FieldKey(stringLiteral: "point")
    static let user_id = FieldKey(stringLiteral: "user_id")
    }
}
