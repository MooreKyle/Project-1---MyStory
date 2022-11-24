//
//  PosterCollectionViewCell.swift
//  Flixster
//
//  Created by Mari Batilando on 11/23/22.
//

import UIKit
import Alamofire
import AlamofireImage

class PosterCollectionViewCell: UICollectionViewCell {
  static let identifier = "PosterCollectionViewCell"
  
  @IBOutlet weak var posterImageView: UIImageView!
  private var imageRequest: DataRequest?
  
  func configure(with movie: Movie) {
    if let posterURL = movie.posterURL {
      AF.request(posterURL).responseImage { [unowned self] response in
        if case .success(let image) = response.result {
          posterImageView.image = image
        }
      }
    }
  }
  
  override func prepareForReuse() {
    posterImageView.image = nil
    imageRequest?.cancel()
    imageRequest = nil
  }
}
