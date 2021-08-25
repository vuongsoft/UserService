//
//  File.swift
//  
//
//  Created by Duc Hai NGUYEN on 21/08/2021.
//

import Fluent

struct DelRated: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema(Address.v21082021_102.schemaName)
      .deleteField(Address.v21082022_102.vung_mien)
      .update()
  }

  func revert(on database: Database) -> EventLoopFuture<Void> {
    database.schema(Address.v21082021_102.schemaName).delete()
  }
}
