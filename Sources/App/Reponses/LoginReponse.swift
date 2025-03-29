//
//  File.swift
//  grocery-app-server
//
//  Created by Moïse VanKeymeulen on 29/03/2025.
//

import Foundation
import Vapor

struct LoginReponse: Content {
  
  let error: Bool
  var reason: String? = nil
  let token: String?
  let userId: UUID?
}
