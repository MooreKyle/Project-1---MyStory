//
//  MovieAPI.swift
//  Flixster
//
//  Created by Mari Batilando on 11/23/22.
//

import Foundation

class MovieAPI {
  static let shared = MovieAPI()
  
  func fetchNowPlayingMovies(completion: @escaping (([Movie]) -> Void)) {
    let urlRequest = try! URLRequest(url: "https://api.themoviedb.org/3/movie/now_playing?api_key=bd8a2862db8113b36277695538edceeb",
                                     method: .get)
    let urlSession = URLSession(configuration: .default,
                                delegate: nil,
                                delegateQueue: .main)
    let dataTask = urlSession.dataTask(with: urlRequest) { [unowned self] data, response, error in
      guard let data = data, error == nil else { return }
      completion(self.parseResponse(data))
    }
    dataTask.resume()
  }
  
  private func parseResponse(_ data: Data) -> [Movie] {
    let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
    return movieResponse?.results ?? []
  }
}
