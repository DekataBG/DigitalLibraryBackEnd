import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

    app.migrations.add(CreateBook())
    app.migrations.add(PopulateBookTable())
    app.migrations.add(CreateUser())

    guard let secretKeyPath = Environment.get("PUBLIC_KEY"),
          let pem = try? String(contentsOfFile: secretKeyPath, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines),
          let publicKey = try? Insecure.RSA.PublicKey(pem: pem) else { return }

    await app.jwt.keys.addRSA(key: publicKey, digestAlgorithm: .sha256)

    // register routes
    try routes(app)
}
