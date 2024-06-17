//
//  UserDTO.swift
//
//
//  Created by Desislav Adamov on 16.06.24.
//

import Fluent
import Vapor

struct UserDTO: Content {
    let id: UUID?
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let readingBooks: [BookDTO]?
    let readBooks: [BookDTO]?

    func toModel() -> User {
        let model = User()

        model.id = id
        model.firstName = firstName
        model.lastName = lastName
        model.email = email
        model.phoneNumber = phoneNumber
        model.readingBooks = readingBooks?.map { $0.toModel() }
        model.readBooks = readBooks?.map { $0.toModel() }

        return model
    }
}
