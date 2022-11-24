//
//  PostersViewController.swift
//  Flixster
//
//  Created by Mari Batilando on 11/23/22.
//

import UIKit

class PostersViewController: UIViewController,
                             UICollectionViewDelegate,
                             UICollectionViewDataSource,
                             UICollectionViewDelegateFlowLayout {
  
  private let kSegueIdentifier = "ShowMovieDetailFromPosterSegue"

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
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: CGRectGetWidth(collectionView.frame) / 3,
                  height: CGRectGetHeight(collectionView.frame) / 3)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier,
                                                  for: indexPath) as! PosterCollectionViewCell
    cell.configure(with: movies[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedMovie = movies[indexPath.row]
    performSegue(withIdentifier: kSegueIdentifier, sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == kSegueIdentifier else { return }
    let detailViewController = segue.destination as! MovieDetailsViewController
    detailViewController.movie = selectedMovie
  }
}
