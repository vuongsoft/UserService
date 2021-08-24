//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 07/08/2021.
//

import Vapor
import SendGrid

struct UsersController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let usersGroup = routes.grouped("users")
    usersGroup.get(use: getAllHandler)
    usersGroup.get(":userID", use: getHandler)
    usersGroup.post(use: createHandler)
    usersGroup.put(":userID", use: updateHandler)
    
    usersGroup.get(":userID", "usersub", use: getUserSubHandler)
    
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
    }/*.flatMap { (userResponse) in
        let subject: String = "Chào mừng bạn đến với bujo"
        let body: String = "Chào mừng bạn đến với bujo!"
        let name = [user.name].compactMap({ $0 }).joined(separator: " ")
        let from = EmailAddress(email: "vuongsoft.vn@gmail.com", name: nil)
        let address = EmailAddress(email: user.email, name: name)
        let header = Personalization(to: [address], subject: subject)
        let email = SendGridEmail(personalizations: [header], from: from, subject: subject, content: [[
            "type": "text",
            "value": body
            ]])
        
        do {
            return try req.application.sendgrid.client.send(email: email, on: req.eventLoop).transform(to: userResponse)
        }
        catch {
            return req.eventLoop.makeFailedFuture(error)
        }
    } */
    
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
    
    func getUserSubHandler(_ req: Request) -> EventLoopFuture<[UserSub]> {
      User.find(req.parameters.get("userID"), on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { user in
          user.$usersub.get(on: req.db)
        }
    }
    
}
