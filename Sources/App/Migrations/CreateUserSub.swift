//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 17/08/2021.
//

import Fluent

struct CreateUserSub: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(UserSub.v102.schemaName)
      .id()
      .field(UserSub.v102.type, .int, .required)
      .field(UserSub.v102.expired, .string, .required)
      .field(UserSub.v102.point, .double, .required)
      .field("createdAt", .datetime)
      .field("updatedAt", .datetime)
      .field("deletedAt", .datetime)
      .field(UserSub.v102.user_id, .uuid, .required, .references(User.v102.schemaName, User.v102.id))
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(UserSub.v102.schemaName).delete()
  }
}

extension UserSub {
    enum v102 {
    static let schemaName = "usersub"
        
    static let id = FieldKey(stringLiteral: "id")
    static let type = FieldKey(stringLiteral: "type")
    static let point = FieldKey(stringLiteral: "point")
    static let expired = FieldKey(stringLiteral: "expired")
    static let user_id = FieldKey(stringLiteral: "user_id")
    }
}
