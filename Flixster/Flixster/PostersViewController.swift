//
//  PostersViewController.swift
//  Flixster
//
//  Created by Mari Batilando on 11/23/22.
//

import UIKit

class PostersViewController: UIViewController,
                             UICollectionViewDelegate,
                             UICollectionViewDataSource {

  @IBOutlet weak var collectionView: UICollectionView!
  private var movies = [Movie]() {
    didSet {
      collectionView.reloadData()
    }
  }
  private var selectedMovie: Movie?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    MovieAPI.shared.fetchNowPlayingMovies { [unowned self] movies in
      self.movies = movies
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}
