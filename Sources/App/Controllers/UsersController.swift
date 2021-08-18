//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 07/08/2021.
//

import Vapor

struct UsersController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let usersGroup = routes.grouped("users")
    usersGroup.get(use: getAllHandler)
    usersGroup.get(":userID", use: getHandler)
    usersGroup.post(use: createHandler)
    usersGroup.put(":userID", use: updateHandler)
    
  }

  func getAllHandler(_ req: Request) -> EventLoopFuture<[User.Public]> {
    User.query(on: req.db).all().convertToPublic()
  }

  func getHandler(_ req: Request) -> EventLoopFuture<User.Public> {
    User.find(req.parameters.get("userID"), on: req.db).unwrap(or: Abort(.notFound)).convertToPublic()
  }

  func createHandler(_ req: Request) throws -> EventLoopFuture<User.Public> {
    let user = try req.content.decode(User.self)
    user.password = try Bcrypt.hash(user.password)
    return user.save(on: req.db).map {
      user.convertToPublic()
    }
  }
    
    func updateHandler(_ req: Request) throws -> EventLoopFuture<User.Public> {
      let updatedUser = try req.content.decode(User.self)
      return User.find(req.parameters.get("userID"), on: req.db)
        .unwrap(or: Abort(.notFound)).flatMap { user in
          user.name = updatedUser.name
          user.username = updatedUser.username
          user.email = updatedUser.email
          user.phone = updatedUser.phone
          user.gender = updatedUser.gender
          user.avatar = updatedUser.avatar
          user.birthday = updatedUser.birthday
          user.pointing = updatedUser.pointing
          user.address_id = updatedUser.address_id
            
          return user.save(on: req.db).map {
            user.convertToPublic()
          }
      }
    }
    
}
