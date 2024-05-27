import Fluent

struct CreateBook: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("books")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("author", .string, .required)
            .field("publisher", .string, .required)
            .field("year", .int, .required)
            .field("genre", .string, .required)
            .field("isbn", .string, .required)
            .field("returning-deadline", .date)
            .field("is-taken", .bool, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("books").delete()
    }
}
