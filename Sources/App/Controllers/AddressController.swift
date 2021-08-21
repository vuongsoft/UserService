//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 16/08/2021.
//

import Vapor
import Fluent

struct AddressController: RouteCollection {
    
  func boot(routes: RoutesBuilder) throws {
    let addressRoute = routes.grouped("address")
    addressRoute.post(use: createHandler)
    addressRoute.get(use: getAllHandler)
    addressRoute.get(":addressID", use: getHandler)
    addressRoute.put(":addressID", use: updateHandler)
}

  func createHandler(_ req: Request) throws -> EventLoopFuture<Address> {
    let address = try req.content.decode(Address.self)
    return address.save(on: req.db).map { address }
  }
    
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Address]> {
        Address.query(on: req.db).all()
    }
  
    func getHandler(_ req: Request) -> EventLoopFuture<Address> {
        Address.find(req.parameters.get("addressID"), on: req.db)
          .unwrap(or: Abort(.notFound))
    }
    
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Address> {
      let updatedAddress = try req.content.decode(Address.self)
      return Address.find(req.parameters.get("addressID"), on: req.db)
        .unwrap(or: Abort(.notFound)).flatMap { address in
            address.lat = updatedAddress.lat
            address.long = updatedAddress.long
            address.so_nha = updatedAddress.so_nha
            address.phuong_xa = updatedAddress.phuong_xa
            address.quan_huyen = updatedAddress.quan_huyen
            address.tinh_thanh = updatedAddress.tinh_thanh
            
          return address.save(on: req.db).map {
            address
          }
      }
    }
    
}
