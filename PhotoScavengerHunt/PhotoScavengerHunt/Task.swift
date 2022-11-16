//
//  Task.swift
//  PhotoScavengerHunt
//
//  Created by Mari Batilando on 11/15/22.
//

import Foundation
import UIKit
import CoreLocation

let HARDCODED_TASKS: [Task] = [
  Task(title: "Your favorite local restaurant",
       description: "Where do you like to go on your cheat days?"),
  Task(title: "Your favorite local cafe",
       description: "Your favorite coffee shop vibe"),
  Task(title: "Your go-to brunch place",
       description: "Where do you go after a long night of partying?"),
  Task(title: "Your favorite hiking spot",
       description: "Where do you go to be one with nature?")
]

class Task {
  let title: String
  let description: String
  private(set) var image: UIImage?
  var imageLocation: CLLocation?
  var isCompleted: Bool {
    return image != nil
  }
  
  init(title: String, description: String, image: UIImage? = nil) {
    self.title = title
    self.description = description
    self.image = image
  }
  
  func setImage(_ image: UIImage, with location: CLLocation) {
    self.image = image
    self.imageLocation = location
  }
}
