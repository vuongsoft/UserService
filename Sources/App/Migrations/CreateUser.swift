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
    database.schema(User.v21082021_102.schemaName)
        .id()
        .field(User.v21082021_102.name, .string, .required)
        .field(User.v21082021_102.username, .string, .required)
        .unique(on: User.v21082021_102.username)
        .field(User.v21082021_102.password, .string, .required)
        .field(User.v21082021_102.email, .string, .required)
        .field(User.v21082021_102.phone, .string, .required)
        .field(User.v21082021_102.gender, .string)
        .field(User.v21082021_102.avatar, .string)
        .field(User.v21082021_102.birthday, .string)
        .field("createdAt", .datetime)
        .field("updatedAt", .datetime)
        .field("deletedAt", .datetime)
        .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(User.v21082021_102.schemaName).delete()
  }
}

extension User {
    enum v21082021_102 {
    static let schemaName = "users"
        
    static let id = FieldKey(stringLiteral: "id")
    static let name = FieldKey(stringLiteral: "name")
    static let username = FieldKey(stringLiteral: "username")
    static let password = FieldKey(stringLiteral: "password")
    static let email = FieldKey(stringLiteral: "email")
    static let phone = FieldKey(stringLiteral: "phone")
    static let gender = FieldKey(stringLiteral: "gender")
    static let avatar = FieldKey(stringLiteral: "avatar")
    static let birthday = FieldKey(stringLiteral: "birthday")
    }
}
