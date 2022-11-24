//
//  Movie.swift
//  Flixster
//
//  Created by Mari Batilando on 11/22/22.
//

import Foundation

struct MovieResponse: Codable {
  let results: [Movie]
}

struct Movie: Codable {
  let id: Int
  let title: String
  let overview: String
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
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case popularity
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

let HARDCODED_MOVIES = [Movie(id: 1,
                              title: "Black Adam",
                              overview: "Nearly 5,000 years after he was bestowed with the almighty powers of the Egyptian gods—and imprisoned just as quickly—Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.",
                              posterPath: "/pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg",
                              backdropPath: "/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg",
                              voteAverage: 5.5,
                              voteCount: 134,
                              popularity: 13.8),
                        Movie(id: 2,
                              title: "Watchmen",
                              overview: "In a gritty and alternate 1985 the glory days of costumed vigilantes have been brought to a close by a government crackdown, but after one of the masked veterans is brutally murdered, an investigation into the killer is initiated. The reunited heroes set out to prevent their own destruction, but in doing so uncover a sinister plot that puts all of humanity in grave danger.",
                              posterPath: "/lpJPbIG9sXjbk41b3zqcfntrICG.jpg",
                              backdropPath: "/dH7ia3vtkYCa3CBvDnvVjqm9uiQ.jpg",
                              voteAverage: 7.5,
                              voteCount: 165,
                              popularity: 34.8),
                        Movie(id: 3,
                              title: "The Tigger Movie",
                              overview: "Winnie the Pooh, Piglet, Owl, Kanga, Roo, and Rabbit are preparing a suitable winter home for Eeyore, the perennially dejected donkey, but Tigger's continual bouncing interrupts their efforts. Rabbit suggests that Tigger go find others of his kind to bounce with, but Tigger thinks \"the most wonderful thing about tiggers is\" he's \"the only one!\" Just in case though, the joyously jouncy feline sets out to see if he can find relatives.",
                              posterPath: "/lxuiGvLHIL1ZyePP7bn6FcKj0Mr.jpg",
                              backdropPath: "/uMoSM7r4dst4e5aFUhDEDPyh1hL.jpg",
                              voteAverage: 7.5,
                              voteCount: 431,
                              popularity: 31.8),
                        Movie(id: 4,
                              title: "Annie",
                              overview: "An orphan in a facility run by the mean Miss Hannigan, Annie believes that her parents left her there by mistake. When a rich man named Oliver \"Daddy\" Warbucks decides to let an orphan live at his home to promote his image, Annie is selected. While Annie gets accustomed to living in Warbucks' mansion, she still longs to meet her parents. So Warbucks announces a search for them and a reward, which brings out many frauds.",
                              posterPath: "/pPJ1HsJh1fjAUlvSJMLCYKriDnX.jpg",
                              backdropPath: "/omvnhpsp7nmW2HUgmrPrFcmUWIk.jpg",
                              voteAverage: 7.5,
                              voteCount: 165,
                              popularity: 34.8),
                        Movie(id: 5,
                              title: "Batman Beyond: Return of the Joker",
                              overview: "The Joker is back with a vengeance, and Gotham's newest Dark Knight, Terry McGinnis, needs answers as he stands alone to face Gotham's most infamous Clown Prince of Crime.",
                              posterPath: "/7RlBs0An83fqAuKfwH5gKMcqgMc.jpg",
                              backdropPath: "/aTlq9POtvgdheYGb5itxp32qg4S.jpg",
                              voteAverage: 7.5,
                              voteCount: 165,
                              popularity: 34.8),
                        Movie(id: 6,
                              title: "Creepshow",
                              overview: "Inspired by the E.C. comics of the 1950s, George A. Romero and Stephen King bring five tales of terror to the screen.",
                              posterPath: "/4SoyTCEpsgLjX6yAyMsx3AsAyRQ.jpg",
                              backdropPath: "/8aqTmCHLkktH7RZNALeaOMneHSl.jpg",
                              voteAverage: 7.5,
                              voteCount: 165,
                              popularity: 34.8),
                        Movie(id: 7,
                              title: "Astro Boy",
                              overview: "Set in the futuristic Metro City, Astro Boy (Atom) is a young robot with incredible powers created by a brilliant scientist in the image of the son he had lost. Unable to fulfill his creator's expectations, Astro embarks on a journey in search of acceptance, experiencing betrayal and a netherworld of robot gladiators, before returning to save Metro City and reconcile with the father who rejected him.",
                              posterPath: "/fYOJaaCpqq1NatziVJntmsXXDi8.jpg",
                              backdropPath: "/qXD5vfFe1blOXJbOHXlU5CYJMQB.jpg",
                              voteAverage: 7.5,
                              voteCount: 165,
                              popularity: 34.8),
                        Movie(id: 8,
                              title: "Mindhunters",
                              overview: "Trainees in the FBI's psychological profiling program must put their training into practice when they discover a killer in their midst.",
                              posterPath: "/uTTGRvnqCI9ZC7WkyP9u7XRiOaA.jpg",
                              backdropPath: "/j30knUpNbspOSehJi5SOJ4wvOVh.jpg",
                              voteAverage: 7.5,
                              voteCount: 165,
                              popularity: 34.8),
                        Movie(id: 9,
                              title: "Punisher: War Zone",
                              overview: "Waging his one-man war on the world of organized crime, ruthless vigilante-hero Frank Castle sets his sights on overeager mob boss Billy Russoti. After Russoti is left horribly disfigured by Castle, he sets out for vengeance under his new alias: Jigsaw. With the \"Punisher Task Force\" hot on his trail and the FBI unable to take Jigsaw in, Frank must stand up to the formidable army that Jigsaw has recruited before more of his evil deeds go unpunished.",
                              posterPath: "/oOvKJgYUIpfswGHAdW6159bPbvM.jpg",
                              backdropPath: "/dqPZpQy6PJINOJtld17NgIERusH.jpg",
                              voteAverage: 7.5,
                              voteCount: 165,
                              popularity: 34.8)]
