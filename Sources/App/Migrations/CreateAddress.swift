//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 16/08/2021.
//

import Fluent

struct CreateAddress: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(Address.v21082021_102.schemaName)
    .id()
    .field(Address.v21082021_102.lat, .double)
    .field(Address.v21082021_102.long, .double)
    .field(Address.v21082021_102.so_nha, .string, .required)
    .field(Address.v21082021_102.phuong_xa, .string, .required)
    .field(Address.v21082021_102.quan_huyen, .string, .required)
    .field(Address.v21082021_102.tinh_thanh, .string, .required)
    .field(Address.v21082021_102.user_id, .uuid, .required, .references(User.v21082021_102.schemaName, User.v21082021_102.id))
    .field("createdAt", .datetime)
    .field("updatedAt", .datetime)
    .field("deletedAt", .datetime)
    .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema(Address.v21082021_102.schemaName).delete()
  }
}

extension Address {
    enum v21082021_102 {
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
    
    enum v21082022_102 {
     static let vung_mien = FieldKey(stringLiteral: "vung_mien")
    }
    
}
