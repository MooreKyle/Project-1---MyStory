//
//  MovieTableViewCell.swift
//  Flixster
//
//  Created by Mari Batilando on 11/23/22.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieTableViewCell: UITableViewCell {
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  static let identifier = "MovieTableViewCell"
  private var movie: Movie!
  private var imageRequest: DataRequest?
  
  override func setSelected(_ selected: Bool, animated: Bool) {}
  
  func configure(with movie: Movie) {
    titleLabel.text = movie.title
    descriptionLabel.text = movie.description
    imageRequest = AF.request(movie.posterURL).responseImage { [unowned self] response in
      if case .success(let image) = response.result {
        posterImageView.image = image
      }
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = ""
    descriptionLabel.text = ""
    posterImageView.image = nil
    imageRequest?.cancel()
    imageRequest = nil
  }
}
