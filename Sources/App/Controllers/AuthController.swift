//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 07/08/2021.
//

import Vapor
import Redis
import Fluent

struct AuthController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let authGroup = routes.grouped("auth")
    // 2
    let basicMiddleware = User.authenticator()
    // 3
    let basicAuthGroup = authGroup.grouped(basicMiddleware)
    // 4
    basicAuthGroup.post("login", use: loginHandler)
    authGroup.post("authenticate", use: authenticate)
  }

  func loginHandler(_ req: Request)
    throws -> EventLoopFuture<Token> {
      // 1
      let user = try req.auth.require(User.self)
      // 2
      let token = try Token.generate(for: user)
      // 3
      return req.redis
        .set(RedisKey(token.tokenString), toJSON: token)
        .transform(to: token)
  }

  func authenticate(_ req: Request)
    throws -> EventLoopFuture<User.Public> {
      // 1
      let data = try req.content.decode(AuthenticateData.self)
      // 2
      return req.redis
        .get(RedisKey(data.token), asJSON: Token.self)
        .flatMap { token in
        // 3
        guard let token = token else {
          return req.eventLoop.future(error: Abort(.unauthorized))
        }
        // 4
        return User.query(on: req.db)
          .filter(\.$id == token.userID)
          .first()
          .unwrap(or: Abort(.internalServerError))
          .convertToPublic()
      }
  }
}


struct AuthenticateData: Content {
  let token: String
}
