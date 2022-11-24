//
//  Post.swift
//  BeRealClone
//
//  Created by Mari Batilando on 11/24/22.
//

import Foundation
import ParseSwift

struct Post: ParseObject {
  // Required by `ParseObject`.
  var originalData: Data?
  var objectId: String?
  var createdAt: Date?
  var updatedAt: Date?
  var ACL: ParseSwift.ParseACL?
  
  // Custom Properties
  var user: User?
  var image: ParseFile?
  var caption: String?
}
