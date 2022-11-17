//
//  ContextItem.swift
//  MyStory
//
//  Created by Mari Batilando on 11/16/22.
//

import Foundation
import UIKit

let HARDCODED_CONTEXT_ITEMS = [ContextItem(title: "My cool backstory",
                                           description: "American teenager Peter Parker, a poor sickly orphan, is bitten by a radioactive spider. As a result of the bite, he gains superhuman strength, speed, and agility, along with the ability to cling to walls, turning him into Spider-Man.",
                                           image: UIImage(named: "bite")!
                                          ),
                               ContextItem(title: "My only weakness",
                                           description: "Ethyl chloride is essentially Spider-Man's Kryptonite and it renders anyone's spider-powers null and void. This makes ethyl chloride extremely powerful against Spider-Man, but this chemical cocktail doesn't have nearly the same reputation as Superman's Kryptonite.",
                                           image: UIImage(named: "weakness")!
                                          ),
                               ContextItem(title: "How much can I lift?",
                                           description: "Like his namesake, Spider-Man's strength and agility stand far above those of the average human, allowing him to lift nearly ten tons and to leap and move at incredible speeds with high accuracy.",
                                           image: UIImage(named: "lift")!)]

struct ContextItem {
  let title: String
  let description: String
  let image: UIImage
}
