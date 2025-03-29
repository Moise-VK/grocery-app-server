//
//  File.swift
//  grocery-app-server
//
//  Created by Moïse VanKeymeulen on 29/03/2025.
//

import Foundation
import JWT

struct AuthPayload: JWTPayload {
  typealias Payload = AuthPayload
  
  enum CodingKeys: String, CodingKey {
    case expiration = "exp"
    case userId = "userId"
  }
  
  var expiration: ExpirationClaim
  var userId: UUID
  
  func verify(using signer: JWTSigner) throws {
    try self.expiration.verifyNotExpired()
  }
}
