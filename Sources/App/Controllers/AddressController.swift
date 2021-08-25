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
    
    addressRoute.get(":addressID", "user", use: getUserHandler)
}

  func createHandler(_ req: Request) throws -> EventLoopFuture<Address> {
    let data = try req.content.decode(CreateAddressData.self)
    
    let address = Address(
        so_nha: data.so_nha,
        phuong_xa: data.phuong_xa,
        quan_huyen: data.quan_huyen,
        tinh_thanh: data.tinh_thanh,
        user_id: data.user_id)
    
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
      let updatedAddress = try req.content.decode(CreateAddressData.self)
      return Address.find(req.parameters.get("addressID"), on: req.db)
        .unwrap(or: Abort(.notFound)).flatMap { address in
            address.lat = updatedAddress.lat
            address.long = updatedAddress.long
            address.so_nha = updatedAddress.so_nha
            address.phuong_xa = updatedAddress.phuong_xa
            address.quan_huyen = updatedAddress.quan_huyen
            address.tinh_thanh = updatedAddress.tinh_thanh
            address.$user.id = updatedAddress.user_id
            
          return address.save(on: req.db).map {
            address
          }
      }
    }
    
    func getUserHandler(_ req: Request) -> EventLoopFuture<User> {
      Address.find(req.parameters.get("addressID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap { address in
        address.$user.get(on: req.db)
      }
    }
    
}

struct CreateAddressData: Content {
    let lat: Double?
    let long: Double?
    let so_nha: String
    let phuong_xa: String
    let quan_huyen: String
    let tinh_thanh: String
    let user_id: UUID
}
