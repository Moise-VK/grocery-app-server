//
//  File.swift
//  grocery-app-server
//
//  Created by Moïse VanKeymeulen on 26/03/2025.
//

import Foundation
import Vapor

struct RegisterResponseDTO: Content {
  let error: Bool
  var reason: String? = nil
}
