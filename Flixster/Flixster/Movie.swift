//
//  Movie.swift
//  Flixster
//
//  Created by Mari Batilando on 11/22/22.
//

import Foundation

let HARDCODED_MOVIES = [Movie(title: "Black Adam",
                              description: "Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods—and imprisoned just as quickly—Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.",
                              posterPath: "/pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg",
                              backdropPath: "/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg")]

struct Movie: Codable {
  let title: String
  let description: String
  let posterPath: String
  let backdropPath: String
}
