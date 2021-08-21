//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 19/08/2021.
//

import Vapor
import Fluent

struct RatingController: RouteCollection {
    
  func boot(routes: RoutesBuilder) throws {
    let ratingRoute = routes.grouped("rating")
    ratingRoute.post(use: createHandler)
    ratingRoute.get(use: getAllHandler) // For deve test ONLY
    ratingRoute.get(":ratingID", use: getHandler)
}

  func createHandler(_ req: Request) throws -> EventLoopFuture<Rating> {
    let rating = try req.content.decode(Rating.self)
    return rating.save(on: req.db).map { rating }
  }
    
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Rating]> {
        Rating.query(on: req.db).all()
    }
  
    func getHandler(_ req: Request) -> EventLoopFuture<Rating> {
        Rating.find(req.parameters.get("ratingID"), on: req.db)
          .unwrap(or: Abort(.notFound))
    }
    
}
