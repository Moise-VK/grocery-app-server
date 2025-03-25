//
//  File.swift
//  grocery-app-server
//
//  Created by Moïse VanKeymeulen on 24/03/2025.
//

import Foundation
import Fluent
import Vapor

final class User: Model, @unchecked Sendable, Content, Validatable {
    
    
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    init() {}
    
    init(id: UUID? = nil, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
    
    static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self, is: !.empty, customFailureDescription: "Username should not be empty")
        validations.add("password", as: String.self, is: !.empty, customFailureDescription: "Password should not be empty")
        
        //password should be longer than 8 characters
        validations.add("password", as: String.self, is: .count(9...), customFailureDescription: "Password should be longer than 8 characters")
    }
}
