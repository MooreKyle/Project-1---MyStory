//
//  PhotoAnnotationView.swift
//  PhotoScavengerHunt
//
//  Created by Mari Batilando on 11/15/22.
//

import UIKit
import MapKit

class PhotoAnnotationView: MKAnnotationView {
  static let identifier = "PhotoAnnotationView"
  private var task: Task!
  private lazy var containerView: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
    view.backgroundColor = .white
    view.layer.cornerRadius = 16.0
    return view
  }()
  private lazy var imageView: UIImageView = {
    let imageview = UIImageView()
    imageview.translatesAutoresizingMaskIntoConstraints = false
    imageview.layer.cornerRadius = 8.0
    imageview.clipsToBounds = true
    return imageview
  }()
  private lazy var bottomCornerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.layer.cornerRadius = 4.0
    return view
  }()
  
  override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    containerView.addSubview(bottomCornerView)
    bottomCornerView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.0).isActive = true
    bottomCornerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    bottomCornerView.widthAnchor.constraint(equalToConstant: 24).isActive = true
    bottomCornerView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    
    let angle = (39.0 * CGFloat.pi) / 180
    let transform = CGAffineTransform(rotationAngle: angle)
    bottomCornerView.transform = transform
    
    addSubview(containerView)
    containerView.addSubview(imageView)
    imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8.0).isActive = true
    imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8.0).isActive = true
    imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8.0).isActive = true
    imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8.0).isActive = true
  }
  
  func configure(with task: Task) {
    self.task = task
    imageView.image = task.image
  }
}
