//
//  ContextItemViewController.swift
//  MyStory
//
//  Created by Mari Batilando on 11/16/22.
//

import UIKit

class ContextItemViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  var contextItem: ContextItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure(with: contextItem)
  }
  
  private func configure(with contextItem: ContextItem?) {
      if let contextItem = contextItem {
          navigationItem.title = contextItem.title
          imageView.image = contextItem.image
          descriptionLabel.text = contextItem.description
      }
      else {
          print ("nil")
      }
  }
}
