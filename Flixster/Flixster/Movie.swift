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
                              backdropPath: "/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg",
                              voteAverage: 5.5,
                              voteCount: 134,
                              popularity: 13.8),
                        Movie(title: "Watchmen",
                              description: "In a gritty and alternate 1985 the glory days of costumed vigilantes have been brought to a close by a government crackdown, but after one of the masked veterans is brutally murdered, an investigation into the killer is initiated. The reunited heroes set out to prevent their own destruction, but in doing so uncover a sinister plot that puts all of humanity in grave danger.",
                              posterPath: "/lpJPbIG9sXjbk41b3zqcfntrICG.jpg",
                              backdropPath: "/dH7ia3vtkYCa3CBvDnvVjqm9uiQ.jpg",
                              voteAverage: 7.5,
                              voteCount: 165,
                              popularity: 34.8),
                        Movie(title: "The Tigger Movie",
                              description: "Winnie the Pooh, Piglet, Owl, Kanga, Roo, and Rabbit are preparing a suitable winter home for Eeyore, the perennially dejected donkey, but Tigger's continual bouncing interrupts their efforts. Rabbit suggests that Tigger go find others of his kind to bounce with, but Tigger thinks \"the most wonderful thing about tiggers is\" he's \"the only one!\" Just in case though, the joyously jouncy feline sets out to see if he can find relatives.",
                              posterPath: "/lxuiGvLHIL1ZyePP7bn6FcKj0Mr.jpg",
                              backdropPath: "/uMoSM7r4dst4e5aFUhDEDPyh1hL.jpg",
                              voteAverage: 7.5,
                              voteCount: 431,
                              popularity: 31.8),
                        Movie(title: "Annie",
                              description: "An orphan in a facility run by the mean Miss Hannigan, Annie believes that her parents left her there by mistake. When a rich man named Oliver \"Daddy\" Warbucks decides to let an orphan live at his home to promote his image, Annie is selected. While Annie gets accustomed to living in Warbucks' mansion, she still longs to meet her parents. So Warbucks announces a search for them and a reward, which brings out many frauds.",
                              posterPath: "/pPJ1HsJh1fjAUlvSJMLCYKriDnX.jpg",
                              backdropPath: "/omvnhpsp7nmW2HUgmrPrFcmUWIk.jpg",
                              voteAverage: 7.5,
                              voteCount: 165,
                              popularity: 34.8)]

struct Movie: Codable {
  let title: String
  let description: String
  let posterPath: String
  let backdropPath: String
  let voteAverage: Double
  let voteCount: Int
  let popularity: Double
  
  var posterURL: URL {
    return URL(string: "https://image.tmdb.org/t/p/w185/\(posterPath)")!
  }
  var backdropURL: URL {
    return URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)")!
  }
}
