import Fluent
import Vapor

struct BookController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let books = routes.grouped("books")

        books.get(use: self.index)
        books.post(use: self.create)
        books.group(":bookID") { book in
            book.get(use: self.get)
            book.put(use: self.update)
            book.delete(use: self.delete)
        }
    }

    @Sendable
    func index(req: Request) async throws -> [BookDTO] {
        _ = try await req.jwt.verify(as: GoogleOAuthPayload.self)

        return try await Book.query(on: req.db).all().map { $0.toDTO() }
    }

    @Sendable
    func get(req: Request) async throws -> BookDTO {
        _ = try await req.jwt.verify(as: GoogleOAuthPayload.self)

        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            throw Abort(.notFound)
        }

        return book.toDTO()
    }

    @Sendable
    func create(req: Request) async throws -> HTTPStatus {
        _ = try await req.jwt.verify(as: GoogleOAuthPayload.self)

        let book = try req.content.decode(BookDTO.self).toModel()

        try await book.save(on: req.db)

        return .ok
    }

    @Sendable
    func update(req: Request) async throws -> HTTPStatus {
        _ = try await req.jwt.verify(as: GoogleOAuthPayload.self)

        let book = try req.content.decode(BookDTO.self).toModel()

        guard let savedBook = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            throw Abort(.notFound)
        }

        savedBook.title = book.title
        savedBook.description = book.description
        savedBook.author = book.author
        savedBook.publisher = book.publisher
        savedBook.year = book.year
        savedBook.genre = book.genre
        savedBook.isbn = book.isbn
        savedBook.returningDeadline = book.returningDeadline
        savedBook.isTaken = book.isTaken

        try await savedBook.save(on: req.db)

        return .ok
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        _ = try await req.jwt.verify(as: GoogleOAuthPayload.self)

        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            throw Abort(.notFound)
        }

        try await book.delete(on: req.db)
        return .ok
    }
}
