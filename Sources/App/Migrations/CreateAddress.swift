//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 16/08/2021.
//

import Fluent

struct CreateLocation: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("address")
      .id()
      .field("lat", .double)
      .field("long", .double)
      .field("so_nha", .string, .required)
      .field("phuong_xa", .string, .required)
      .field("quan_huyen", .string, .required)
      .field("tinh_thanh", .string, .required)
      .field("createdAt", .datetime)
      .field("updatedAt", .datetime)
      .field("deletedAt", .datetime)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("location").delete()
  }
}
