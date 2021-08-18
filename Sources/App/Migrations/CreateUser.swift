//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 07/08/2021.
//

import Fluent
import Foundation

struct CreateUser: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("users")
      .id()
      .field("name", .string, .required)
      .field("username", .string, .required)
      .unique(on: "username")
      .field("password", .string, .required)
      .field("email", .string, .required)
      .field("phone", .string, .required)
      .field("gender", .string)
      .field("avatar", .string)
      .field("birthday", .datetime)
      .field("pointing", .int)
      .field("createdAt", .datetime)
      .field("updatedAt", .datetime)
      .field("deletedAt", .datetime)
      .field("address_id", .uuid)
      .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema("users").delete()
  }
}
