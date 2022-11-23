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
  private let movies = HARDCODED_MOVIES
  private var selectedMovie: Movie?
  
  override func viewDidLoad() {
    super.viewDidLoad()
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

