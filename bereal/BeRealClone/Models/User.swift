//
//  User.swift
//  BeRealClone
//
//  Created by Mari Batilando on 11/24/22.
//

import Foundation
import ParseSwift

struct User: ParseUser {
  // Required by `ParseObject`.
  var objectId: String?
  var createdAt: Date?
  var updatedAt: Date?
  var ACL: ParseACL?
  var originalData: Data?
  
  // Required by `ParseUser`.
  var username: String?
  var email: String?
  var emailVerified: Bool?
  var password: String?
  var authData: [String: [String: String]?]?
  
  // Custom Properties
  var lastPostedDate: Date?
}
