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
  
  static let presentMovieDetailSegueIdentifier = "ShowMovieDetailSegue"
  
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var averageScoreLabel: UILabel!
  @IBOutlet weak var numVotesLabel: UILabel!
  @IBOutlet weak var popularityLabel: UILabel!
  
  var movie: Movie!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure(with: movie)
  }
    
  private func configure(with movie: Movie) {
    titleLabel.text = movie.title
    descriptionLabel.text = movie.overview
    averageScoreLabel.text = "\(movie.voteAverage) Vote Average"
    numVotesLabel.text = "\(movie.voteCount) Votes"
    popularityLabel.text = "\(movie.popularity) Popularity"
    AF.request(movie.backdropURL).responseImage { [unowned self] response in
      if case .success(let image) = response.result {
        backdropImageView.image = image
      }
    }
  }
}
