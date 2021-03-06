/// Copyright (c) 2021 Duc Hai Nguyen

import Fluent
import Vapor

func routes(_ app: Application) throws {
  try app.register(collection: UsersController())
  try app.register(collection: AuthController())
  try app.register(collection: AddressController())
  try app.register(collection: RatingController())
  try app.register(collection: UserSubController())
}
