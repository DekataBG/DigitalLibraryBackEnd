//
//  User.swift
//  
//
//  Created by Desislav Adamov on 16.06.24.
//

import Fluent
import struct Foundation.UUID
import struct Foundation.Date

/// Property wrappers interact poorly with `Sendable` checking, causing a warning for the `@ID` property
/// It is recommended you write your model with sendability checking on and then suppress the warning
/// afterwards with `@unchecked Sendable`.
final class User: Model, @unchecked Sendable {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "first-name")
    var firstName: String

    @Field(key: "last-name")
    var lastName: String

    @Field(key: "email")
    var email: String

    @Field(key: "phone-number")
    var phoneNumber: String

    @Field(key: "reading-books")
    var readingBooks: [Book]?

    @Field(key: "read-books")
    var readBooks: [Book]?

    init() { }

    init(id: UUID? = UUID(),
         firstName: String,
         lastName: String,
         email: String,
         phoneNumber: String,
         readingBooks: [Book]? = nil,
         readBooks: [Book]? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.readingBooks = readingBooks
        self.readBooks = readBooks
    }

    func toDTO() -> UserDTO {
        .init(id: id,
              firstName: firstName,
              lastName: lastName,
              email: email,
              phoneNumber: phoneNumber,
              readingBooks: readingBooks?.map { $0.toDTO() },
              readBooks: readBooks?.map { $0.toDTO() })
    }
}
