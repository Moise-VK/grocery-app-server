//
//  File.swift
//  grocery-app-server
//
//  Created by Moïse VanKeymeulen on 26/03/2025.
//

import Foundation
import Vapor
import Fluent

struct UserService {
    func createUser(_ user: User, request: Request) async throws -> User {
        if let _ = try await User.query(on: request.db)
            .filter(\.$username == user.username)
            .first() {
            throw Abort(.conflict, reason: "User already exists")
        }

        let newUser = user
      
        newUser.password = try await request.password.async.hash(newUser.password)
      
        try await newUser.save(on: request.db)
      
        return newUser
    }
}
