//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 16/08/2021.
//

import Vapor
import Fluent

final class Address: Model, Content {
    static let schema = "address"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "lat")
    var lat: Double
    
    @Field(key: "long")
    var long: Double
    
    @Field(key: "so_nha")
    var so_nha: String
    
    @Field(key: "phuong_xa")
    var phuong_xa: String
    
    @Field(key: "quan_huyen")
    var quan_huyen: String
    
    @Field(key: "tinh_thanh")
    var tinh_thanh: String
    
    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deletedAt", on: .delete)
    var deletedAt: Date?
    
    init() {
    }
    
    init(id: UUID? = nil, lat: Double, long: Double, so_nha: String, phuong_xa: String, quan_huyen: String, tinh_thanh: String) {
        self.id = id
        self.lat = lat
        self.long = long
        self.so_nha = so_nha
        self.phuong_xa = phuong_xa
        self.quan_huyen = quan_huyen
        self.tinh_thanh = tinh_thanh
    }
}
