//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 17/08/2021.
//

import Fluent

struct CreateRating: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(Rating.v21082021_102.schemaName)
      .id()
        .field(Rating.v21082021_102.content, .string)
        .field(Rating.v21082021_102.point, .int, .required)
      .field("createdAt", .datetime)
      .field("updatedAt", .datetime)
      .field("deletedAt", .datetime)
        .field(Rating.v21082021_102.rater_id, .uuid)
        .field(Rating.v21082021_102.rated_id, .uuid)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(Rating.v21082021_102.schemaName).delete()
  }
}

extension Rating {
    enum v21082021_102 {
    static let schemaName = "rating"
        
    static let id = FieldKey(stringLiteral: "id")
    static let content = FieldKey(stringLiteral: "content")
    static let point = FieldKey(stringLiteral: "point")
    static let rater_id = FieldKey(stringLiteral: "rater_id")
    static let rated_id = FieldKey(stringLiteral: "rated_id")
    }
}
