//
//  File.swift
//  
//
//  Created by Desislav Adamov on 17.06.24.
//

import Fluent

struct CreateUser: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("first-name", .string, .required)
            .field("last-name", .string, .required)
            .field("email", .string, .required)
            .field("phone-number", .string, .required)
            .field("reading-books", .array(of: .custom(Book.self)))
            .field("read-books", .array(of: .custom(Book.self)))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("books").delete()
    }
}
