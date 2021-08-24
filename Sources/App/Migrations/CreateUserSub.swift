//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 17/08/2021.
//

import Fluent

struct CreateUserSub: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(UserSub.v21082021_102.schemaName)
      .id()
      .field(UserSub.v21082021_102.type, .int, .required)
      .field(UserSub.v21082021_102.expired, .string, .required)
      .field("createdAt", .datetime)
      .field("updatedAt", .datetime)
      .field("deletedAt", .datetime)
      .field(UserSub.v21082021_102.user_id, .uuid, .required, .references(User.v21082021_102.schemaName, User.v21082021_102.id))
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(UserSub.v21082021_102.schemaName).delete()
  }
}

extension UserSub {
    enum v21082021_102 {
    static let schemaName = "usersub"
        
    static let id = FieldKey(stringLiteral: "id")
    static let type = FieldKey(stringLiteral: "type")
    static let expired = FieldKey(stringLiteral: "expired")
    static let user_id = FieldKey(stringLiteral: "user_id")
    }
}
