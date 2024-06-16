import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "Hello, world!\nUnauthenticated!"
    }

    app.get("hello") { req async throws -> String in
        _ = try await req.jwt.verify(as: GoogleOAuthPayload.self)

        return "Hello, world!\nAuthenticated!"
    }

    try app.register(collection: BookController())
}
