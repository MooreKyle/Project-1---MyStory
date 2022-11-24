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

  private let kSegueIdentifier = "ShowMovieDetailFromMovieListSegue"
  private var movies = [Movie]() {
    didSet {
      tableView.reloadData()
    }
  }
  private var selectedMovie: Movie?
  var movieRecommendation: Movie?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableView.automaticDimension
    if let movieRecommendation = movieRecommendation {
      navigationItem.title = "Similar Movies to \(movieRecommendation.title)"
      MovieAPI.shared.fetchSimilarMovies(withMovieID: movieRecommendation.id) { [unowned self] movies in
        self.movies = movies
      }
    } else {
      MovieAPI.shared.fetchNowPlayingMovies { [unowned self] movies in
        self.movies = movies
      }
    }
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
    performSegue(withIdentifier: kSegueIdentifier, sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == kSegueIdentifier else { return }
    let movieDetailsViewController = segue.destination as! MovieDetailsViewController
    movieDetailsViewController.movie = selectedMovie!
  }
}

