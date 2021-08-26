//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 16/08/2021.
//

import Fluent

struct CreateAddress: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(Address.v102.schemaName)
    .id()
    .field(Address.v102.lat, .double)
    .field(Address.v102.long, .double)
    .field(Address.v102.so_nha, .string, .required)
    .field(Address.v102.phuong_xa, .string, .required)
    .field(Address.v102.quan_huyen, .string, .required)
    .field(Address.v102.tinh_thanh, .string, .required)
    .field(Address.v102.user_id, .uuid, .required, .references(User.v102.schemaName, User.v102.id))
    .field("createdAt", .datetime)
    .field("updatedAt", .datetime)
    .field("deletedAt", .datetime)
    .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(Address.v102.schemaName).delete()
  }
}

extension Address {
    enum v102 {
    static let schemaName = "address"
        
    static let id = FieldKey(stringLiteral: "id")
    static let lat = FieldKey(stringLiteral: "lat")
    static let long = FieldKey(stringLiteral: "long")
    static let so_nha = FieldKey(stringLiteral: "so_nha")
    static let phuong_xa = FieldKey(stringLiteral: "phuong_xa")
    static let quan_huyen = FieldKey(stringLiteral: "quan_huyen")
    static let tinh_thanh = FieldKey(stringLiteral: "tinh_thanh")
    static let user_id = FieldKey(stringLiteral: "user_id")
    }
}
