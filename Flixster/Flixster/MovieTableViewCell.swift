//
//  MovieTableViewCell.swift
//  Flixster
//
//  Created by Mari Batilando on 11/23/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  static let identifier = "MovieTableViewCell"
  private var movie: Movie!
  
  override func setSelected(_ selected: Bool, animated: Bool) {}
  
  func configure(with movie: Movie) {
    titleLabel.text = movie.title
    descriptionLabel.text = movie.description
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    // cancel image req
  }
}
