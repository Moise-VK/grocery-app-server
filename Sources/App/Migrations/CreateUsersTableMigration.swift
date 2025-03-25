//
//  File.swift
//  grocery-app-server
//
//  Created by Moïse VanKeymeulen on 24/03/2025.
//

import Foundation
import Fluent

struct CreateUsersTableMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required).unique(on: "username")
            .field("password", .string, .required)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("users").delete()
    }
}
