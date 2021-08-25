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
    ratingRoute.put(":ratingID", use: updateHandler)
    
    ratingRoute.get(":ratingID", "user", use: getUserHandler)
}

  func createHandler(_ req: Request) throws -> EventLoopFuture<Rating> {
    let data = try req.content.decode(CreateRatingData.self)
    
    let rating = Rating(
        content: data.content,
        point: data.point,
        user_id: data.user_id)
    return rating.save(on: req.db).map { rating }
  }
    
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Rating]> {
        Rating.query(on: req.db).all()
    }
  
    func getHandler(_ req: Request) -> EventLoopFuture<Rating> {
        Rating.find(req.parameters.get("ratingID"), on: req.db)
          .unwrap(or: Abort(.notFound))
    }
    
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Rating> {
      let updatedRating = try req.content.decode(CreateRatingData.self)
      return Rating.find(req.parameters.get("ratingID"), on: req.db)
        .unwrap(or: Abort(.notFound)).flatMap { rating in
            rating.content = updatedRating.content
            rating.point = updatedRating.point
            rating.$user.id = updatedRating.user_id
            
          return rating.save(on: req.db).map {
            rating
          }
      }
    }
    
    func getUserHandler(_ req: Request) -> EventLoopFuture<User> {
      Rating.find(req.parameters.get("ratingID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap { rating in
        rating.$user.get(on: req.db)
      }
    }
    
}

struct CreateRatingData: Content {
  let content: String
  let point: Int
  let user_id: UUID
}
