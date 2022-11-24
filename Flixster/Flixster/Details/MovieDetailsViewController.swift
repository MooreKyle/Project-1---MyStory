//
//  MovieDetailsViewController.swift
//  Flixster
//
//  Created by Mari Batilando on 11/23/22.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailsViewController: UIViewController {
  
  private let kShowSimilarMoviesSegueIdentifier = "ShowSimilarMoviesSegue"
  
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var averageScoreLabel: UILabel!
  @IBOutlet weak var numVotesLabel: UILabel!
  @IBOutlet weak var popularityLabel: UILabel!
  @IBOutlet weak var seeSimilarMoviesButton: UIButton!
  
  var movie: Movie!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure(with: movie)
  }
  
  @IBAction func didTapSeeSimilarMoviesButton(_ sender: UIButton) {
    performSegue(withIdentifier: kShowSimilarMoviesSegueIdentifier, sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == kShowSimilarMoviesSegueIdentifier else { return }
    let moviesViewController = segue.destination as! MoviesViewController
    moviesViewController.movieRecommendation = movie
  }
    
  private func configure(with movie: Movie) {
    titleLabel.text = movie.title
    descriptionLabel.text = movie.overview
    averageScoreLabel.text = "\(movie.voteAverage) Vote Average"
    numVotesLabel.text = "\(movie.voteCount) Votes"
    popularityLabel.text = "\(movie.popularity) Popularity"
    if let backdropURL = movie.backdropURL {
      AF.request(backdropURL).responseImage { [unowned self] response in
        if case .success(let image) = response.result {
          backdropImageView.image = image
        }
      }
    }
  }
}
