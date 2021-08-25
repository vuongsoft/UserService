//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 16/08/2021.
//

import Vapor
import Fluent

final class Address: Model, Content {
    static let schema = Address.v102.schemaName
    
    @ID(key: .id)
    var id: UUID?
    
    @OptionalField(key: Address.v102.lat)
    var lat: Double?
    
    @OptionalField(key: Address.v102.long)
    var long: Double?
    
    @Field(key: Address.v102.so_nha)
    var so_nha: String
    
    @Field(key: Address.v102.phuong_xa)
    var phuong_xa: String
    
    @Field(key: Address.v102.quan_huyen)
    var quan_huyen: String
    
    @Field(key: Address.v102.tinh_thanh)
    var tinh_thanh: String
    
    @Timestamp(key: "createdAt", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updatedAt", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deletedAt", on: .delete)
    var deletedAt: Date?
    
    @Parent(key: Address.v102.user_id)
    var user: User
    
    init() {
    }
    
    init(id: UUID? = nil, lat: Double? = nil, long: Double? = nil, so_nha: String, phuong_xa: String, quan_huyen: String, tinh_thanh: String, user_id: User.IDValue) {
        self.id = id
        self.lat = lat
        self.long = long
        self.so_nha = so_nha
        self.phuong_xa = phuong_xa
        self.quan_huyen = quan_huyen
        self.tinh_thanh = tinh_thanh
        self.$user.id = user_id
    }
}
