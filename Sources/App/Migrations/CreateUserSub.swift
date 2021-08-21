//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 17/08/2021.
//

import Fluent

struct CreateUserSub: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("usersub")
      .id()
      .field("type", .int, .required)
      .field("expired", .string, .required)
      .field("createdAt", .datetime)
      .field("updatedAt", .datetime)
      .field("deletedAt", .datetime)
      .field("user_id", .uuid)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("usersub").delete()
  }
}
