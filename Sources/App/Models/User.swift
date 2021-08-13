//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 07/08/2021.
//

import Foundation
import Vapor
import Fluent

final class User: Model, Content {
  static let schema = "users"

  @ID
  var id: UUID?

  @Field(key: "name")
  var name: String

  @Field(key: "username")
  var username: String

  @Field(key: "password")
  var password: String
    
  @Field(key: "locationID")
  var locationID: UUID

    init(name: String, username: String, password: String, locationID: UUID) {
    self.name = name
    self.username = username
    self.password = password
    self.locationID = locationID
  }

  init() {}

  final class Public: Content {
    var id: UUID?
    var name: String
    var username: String
    var locationID: UUID

    init(id: UUID?, name: String, username: String, locationID: UUID) {
      self.id = id
      self.name = name
      self.username = username
      self.locationID = locationID
    }
  }
}

extension User {
  func convertToPublic() -> User.Public {
    return User.Public(id: id, name: name, username: username, locationID: locationID)
  }
}

extension EventLoopFuture where Value: User {
  func convertToPublic() -> EventLoopFuture<User.Public> {
    return self.map { user in
      return user.convertToPublic()
    }
  }
}

extension Collection where Element: User {
  func convertToPublic() -> [User.Public] {
    return self.map { $0.convertToPublic() }
  }
}

extension EventLoopFuture where Value == Array<User> {
  func convertToPublic() -> EventLoopFuture<[User.Public]> {
    return self.map { $0.convertToPublic() }
  }
}

extension User: ModelAuthenticatable {
  static let usernameKey = \User.$username
  static let passwordHashKey = \User.$password
  
  func verify(password: String) throws -> Bool {
    try Bcrypt.verify(password, created: self.password)
  }
}
