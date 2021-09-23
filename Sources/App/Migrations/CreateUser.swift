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
    database.schema(User.v102.schemaName)
        .id()
        .field(User.v102.name, .string, .required)
        .field(User.v102.username, .string, .required)
        .unique(on: User.v102.username)
        .field(User.v102.password, .string, .required)
        .field(User.v102.email, .string, .required)
        .unique(on: User.v102.email)
        .field(User.v102.phone, .string, .required)
        .unique(on: User.v102.phone)
        .field(User.v102.gender, .string)
        .field(User.v102.avatar, .string)
        .field(User.v102.birthday, .string)
        .field("createdAt", .datetime)
        .field("updatedAt", .datetime)
        .field("deletedAt", .datetime)
        .create()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(User.v102.schemaName).delete()
  }
}

extension User {
    enum v102 {
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
