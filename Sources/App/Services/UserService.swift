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
  func createUser(_ user: User, request: Request) async throws -> RegisterReponse {
    if let _ = try await User.query(on: request.db)
      .filter(\.$username == user.username)
      .first() {
      throw Abort(.conflict, reason: "User already exists")
    }
    
    let newUser = user
    
    newUser.password = try await request.password.async.hash(newUser.password)
    
    try await newUser.save(on: request.db)
    
    return RegisterReponse(error: false)
  }
  
  func loginUser(_ user: User, request: Request) async throws -> LoginReponse {
    guard let existingUser = try await User.query(on: request.db).filter(\.$username == user.username)
      .first() else {
        throw Abort(.badRequest)
      }
    
    let result = try await request.password.async.verify(user.password, created: existingUser.password)
    
    if !result {
      throw Abort(.badRequest)
    }
    
    let authPayload = try AuthPayload(expiration: .init(value: .distantFuture), userId: existingUser.requireID())
    
   return try LoginReponse(error: false, token: request.jwt.sign(authPayload), userId: existingUser.requireID())
  }
}
