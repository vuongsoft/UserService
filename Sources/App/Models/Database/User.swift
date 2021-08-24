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
    static let schema = User.v21082021_102.schemaName

  @ID
  var id: UUID?

    @Field(key: User.v21082021_102.name)
  var name: String

    @Field(key: User.v21082021_102.username)
  var username: String

    @Field(key: User.v21082021_102.password)
  var password: String
    
    @Field(key: User.v21082021_102.email)
  var email: String

    @Field(key: User.v21082021_102.phone)
  var phone: String
    
    @OptionalField(key: User.v21082021_102.gender)
  var gender: String?
      
    @OptionalField(key: User.v21082021_102.avatar)
  var avatar: String?

    @OptionalField(key: User.v21082021_102.birthday)
  var birthday: String?

    @OptionalField(key: User.v21082021_102.pointing)
  var pointing: Int?

  @Timestamp(key: "createdAt", on: .create)
  var createdAt: Date?
    
  @Timestamp(key: "updatedAt", on: .update)
  var updatedAt: Date?
    
  @Timestamp(key: "deletedAt", on: .delete)
  var deletedAt: Date?
    
  @OptionalField(key: User.v21082021_102.address_id)
  var address_id: UUID?

  @Children(for: \UserSub.$user)
  var usersub: [UserSub]

    init(name: String, username: String, password: String, email: String,
         phone: String, gender: String? = nil, avatar: String? = nil,
         birthday: String? = nil, pointing: Int? = nil, address_id: UUID? = nil) {
    self.name = name
    self.username = username
    self.password = password
    self.email = email
    self.phone = phone
    self.gender = gender
    self.avatar = avatar
    self.birthday = birthday
    self.pointing = pointing
    self.address_id = address_id
  }
    

  init() {}
    
  final class Public: Content {
    var id: UUID?
    var name: String
    var username: String
    var email: String
    var phone: String
    var gender: String?
    var avatar: String?
    var birthday: String?
    var pointing: Int?
    var address_id: UUID?

    init(id: UUID?, name: String, username: String, email: String,
         phone: String, gender: String?, avatar: String?,
         birthday: String?, pointing: Int?, address_id: UUID?) {
      self.id = id
      self.name = name
      self.username = username
      self.email = email
      self.phone = phone
      self.gender = gender
      self.avatar = avatar
      self.birthday = birthday
      self.pointing = pointing
      self.address_id = address_id
    }
  }
    
}

extension User {
  func convertToPublic() -> User.Public {
    return User.Public(id: id, name: name, username: username, email: email, phone: phone, gender: gender, avatar: avatar, birthday: birthday, pointing: pointing, address_id: address_id)
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

