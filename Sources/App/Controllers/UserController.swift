//
//  File.swift
//  grocery-app-server
//
//  Created by Moïse VanKeymeulen on 26/03/2025.
//

import Foundation
import Vapor
import Fluent

final class UserController: RouteCollection, Sendable {
  let userService = UserService()

  func boot(routes: any RoutesBuilder) throws {
    let api = routes.grouped("api")
    
    api.post("register", use: register)
  }
  
  func register(_ req: Request) async throws -> HTTPStatus {
    let user = try req.content.decode(User.self)
            try await userService.createUser(user, request: req)
            return .ok
  }
  
  
}
