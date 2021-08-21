//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 17/08/2021.
//

import Fluent

struct CreateRating: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("rating")
      .id()
      .field("content", .string)
      .field("point", .int, .required)
      .field("createdAt", .datetime)
      .field("updatedAt", .datetime)
      .field("deletedAt", .datetime)
      .field("rater_id", .uuid)
      .field("rated_id", .uuid)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("rating").delete()
  }
}
