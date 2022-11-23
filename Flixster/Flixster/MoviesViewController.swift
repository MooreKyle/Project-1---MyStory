//
//  ViewController.swift
//  Flixster
//
//  Created by Mari Batilando on 11/22/22.
//

import UIKit

class MoviesViewController: UIViewController,
                            UITableViewDelegate,
                            UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!

  private let kMovieDetailSegueIdentifier = "ShowMovieDetailSegue"
  private var movies = [Movie]() {
    didSet {
      tableView.reloadData()
    }
  }
  private var selectedMovie: Movie?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableView.automaticDimension
    fetchMovies()
  }
  
  private func fetchMovies() {
    let urlRequest = try! URLRequest(url: "https://api.themoviedb.org/3/movie/now_playing?api_key=bd8a2862db8113b36277695538edceeb",
                                     method: .get)
    let urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    let dataTask = urlSession.dataTask(with: urlRequest) { [unowned self] data, response, error in
      guard let data = data, error == nil else { return }
      self.parseResponse(data)
    }
    dataTask.resume()
  }
  
  private func parseResponse(_ data: Data) {
    let jsonDecoder = JSONDecoder()
    let movieResponse = try? jsonDecoder.decode(MovieResponse.self, from: data)
    self.movies = movieResponse?.results ?? []
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
    cell.configure(with: movies[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedMovie = movies[indexPath.row]
    performSegue(withIdentifier: kMovieDetailSegueIdentifier, sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == kMovieDetailSegueIdentifier else { return }
    let movieDetailsViewController = segue.destination as! MovieDetailsViewController
    movieDetailsViewController.movie = selectedMovie!
  }
}

