// swift-tools-version:5.2

/// Copyright (c) 2021 Duc Hai Nguyen

import PackageDescription

let package = Package(
  name: "TILAppUsers",
  platforms: [
    .macOS(.v10_15)
  ],
  dependencies: [
    // 💧 A server-side Swift web framework.
    .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
    .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
    .package(url: "https://github.com/vapor/redis.git", from: "4.0.0"),
    .package(url: "https://github.com/vapor/jwt.git", from: "4.0.0"),
    .package(url: "https://github.com/vapor-community/sendgrid.git", from: "4.0.0"),
  ],
  targets: [
    .target(
      name: "App",
      dependencies: [
        .product(name: "Fluent", package: "fluent"),
        .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
        .product(name: "Vapor", package: "vapor"),
        .product(name: "Redis", package: "redis"),
        .product(name: "JWT", package: "jwt"),
        .product(name: "SendGrid", package: "sendgrid"),
      ],
      swiftSettings: [
        // Enable better optimizations when building in Release configuration. Despite the use of
        // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
        // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
        .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
      ]
    ),
    .target(name: "Run", dependencies: [.target(name: "App")]),
  ]
)
