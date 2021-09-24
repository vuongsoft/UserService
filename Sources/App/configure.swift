/// Copyright (c) 2021 Duc Hai Nguyen

import Fluent
import FluentPostgresDriver
import Vapor
import Redis
import SendGrid

// configures your application
public func configure(_ app: Application) throws {

  let port: Int
  if let environmentPort = Environment.get("PORT") {
    port = Int(environmentPort) ?? 8081
  } else {
    port = 8081
  }
  app.http.server.configuration.port = port
  
  app.databases.use(.postgres(
    hostname: Environment.get("DATABASE_HOST") ?? "localhost",
    port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? 54320,
    username: Environment.get("DATABASE_USERNAME") ?? "admin",
    password: Environment.get("DATABASE_PASSWORD") ?? "admin",
    database: Environment.get("DATABASE_NAME") ?? "User_database"
  ), as: .psql)

  app.migrations.add(CreateUser())
  app.migrations.add(CreateAddress())
  app.migrations.add(CreateRating())
  app.migrations.add(CreateUserSub())
    
  //UPDATE DATABASE
 // app.migrations.add(RemoveMienToAddress())

  let redisHostname: String
  if let redisEnvironmentHostname =
    Environment.get("REDIS_HOSTNAME") {
      redisHostname = redisEnvironmentHostname
  } else {
    redisHostname = "localhost"
  }
  // 2
  app.redis.configuration =
    try RedisConfiguration(hostname: redisHostname)
  
  // register routes
  try routes(app)
    
  app.sendgrid.initialize()

  try app.autoMigrate().wait()
}
