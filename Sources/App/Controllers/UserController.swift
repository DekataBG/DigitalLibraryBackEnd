//
//  UserController.swift
//
//
//  Created by Desislav Adamov on 16.06.24.
//

import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")

        users.get(use: self.index)
        users.post(use: self.create)
        users.group(":userID") { user in
            user.get(use: self.get)
            user.put(use: self.update)
            user.delete(use: self.delete)
        }
    }

    @Sendable
    func index(req: Request) async throws -> [UserDTO] {
        _ = try await req.jwt.verify(as: GoogleOAuthPayload.self)

        return try await User.query(on: req.db).all().map { $0.toDTO() }
    }

    @Sendable
    func get(req: Request) async throws -> UserDTO {
        _ = try await req.jwt.verify(as: GoogleOAuthPayload.self)

        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }

        return user.toDTO()
    }

    @Sendable
    func create(req: Request) async throws -> HTTPStatus {
        _ = try await req.jwt.verify(as: GoogleOAuthPayload.self)

        let user = try req.content.decode(UserDTO.self).toModel()

        try await user.save(on: req.db)

        return .ok
    }

    @Sendable
    func update(req: Request) async throws -> HTTPStatus {
        _ = try await req.jwt.verify(as: GoogleOAuthPayload.self)

        let user = try req.content.decode(UserDTO.self).toModel()

        guard let savedUser = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }

        savedUser.firstName = user.firstName
        savedUser.lastName = user.lastName
        savedUser.email = user.email
        savedUser.phoneNumber = user.phoneNumber
        savedUser.readingBooks = user.readingBooks
        savedUser.readBooks = user.readBooks

        try await savedUser.save(on: req.db)

        return .ok
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        _ = try await req.jwt.verify(as: GoogleOAuthPayload.self)

        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }

        try await user.delete(on: req.db)
        return .ok
    }
}
