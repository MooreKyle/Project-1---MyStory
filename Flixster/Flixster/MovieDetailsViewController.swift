//
//  MovieDetailsViewController.swift
//  Flixster
//
//  Created by Mari Batilando on 11/23/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
  
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  var movie: Movie!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure(with: movie)
  }
    
  private func configure(with movie: Movie) {
    titleLabel.text = movie.title
    descriptionLabel.text = movie.description
  }
}
