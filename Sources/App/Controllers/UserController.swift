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
  func boot(routes: any RoutesBuilder) throws {
    let api = routes.grouped("api")
    
    api.post("register", use: register)
  }
  
  func register(_ req: Request) async throws -> HTTPStatus {
    try User.validate(content: req)
    
    let newUser = try req.content.decode(User.self)
    
    if let _ = try await User.query(on: req.db)
      .filter(\.$username == newUser.username)
      .first() {
      throw Abort(.conflict, reason: "User already exists")
    }
    
    newUser.password = try await req.password.async.hash(newUser.password)
    
    try await newUser.save(on: req.db)
    
    return .ok
  }
  
  
}
