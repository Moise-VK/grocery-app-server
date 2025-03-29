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
    api.post("login", use: login)
  }
  
  func register(_ req: Request) async throws -> RegisterReponse {
    let user = try req.content.decode(User.self)
    return try await userService.createUser(user, request: req)
  }
  
  func login(_ req: Request) async throws -> LoginReponse {
    let user = try req.content.decode(User.self)
    
    return try await userService.loginUser(user, request: req)
  }
  
}
