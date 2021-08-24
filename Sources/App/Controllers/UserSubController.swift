//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 19/08/2021.
//

import Vapor
import Fluent

struct UserSubController: RouteCollection {
    
  func boot(routes: RoutesBuilder) throws {
    let usersubRoute = routes.grouped("usersub")
    usersubRoute.post(use: createHandler)
    usersubRoute.get(use: getAllHandler)
    usersubRoute.get(":usersubID", use: getHandler)
    usersubRoute.put(":usersubID", use: updateHandler)
    
    usersubRoute.get(":usersubID", "user", use: getUserHandler)

}

    func createHandler(_ req: Request) throws -> EventLoopFuture<UserSub> {
    let data = try req.content.decode(CreateUserSubData.self)
    
    let usersub = UserSub(
        type: data.type,
        expired: data.expired,
        user_id: data.user_id)
    return usersub.save(on: req.db).map { usersub }
  }
    
    func getAllHandler(_ req: Request) -> EventLoopFuture<[UserSub]> {
        UserSub.query(on: req.db).all()
    }
  
    func getHandler(_ req: Request) -> EventLoopFuture<UserSub> {
        UserSub.find(req.parameters.get("usersubID"), on: req.db)
          .unwrap(or: Abort(.notFound))
    }
    
    func updateHandler(_ req: Request) throws -> EventLoopFuture<UserSub> {
      let updatedUserSub = try req.content.decode(CreateUserSubData.self)
      return UserSub.find(req.parameters.get("usersubID"), on: req.db)
        .unwrap(or: Abort(.notFound)).flatMap { usersub in
            usersub.type = updatedUserSub.type
            usersub.expired = updatedUserSub.expired
            usersub.$user.id = updatedUserSub.user_id
            
          return usersub.save(on: req.db).map {
            usersub
          }
      }
    }
    
    func getUserHandler(_ req: Request) -> EventLoopFuture<User> {
      UserSub.find(req.parameters.get("usersubID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap { usersub in
        usersub.$user.get(on: req.db)
      }
    }
    
}

struct CreateUserSubData: Content {
  let type: Int
  let expired: String
  let user_id: UUID
}
