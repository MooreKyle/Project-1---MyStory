//
//  PostCellTableViewCell.swift
//  BeRealClone
//
//  Created by Mari Batilando on 10/29/22.
//

import UIKit
import Parse

class PostCellTableViewCell: UITableViewCell {
  
  static let identifier = "PostCellTableViewCell"
  
  @IBOutlet private weak var photoImageView: UIImageView!
  @IBOutlet private weak var captionLabel: UILabel!
  @IBOutlet private weak var authorLabel: UILabel!
  @IBOutlet weak var authorInitials: UILabel!
  @IBOutlet weak var authorInitialsContainerView: UIView!
  
  private var imageFileObject: PFFileObject?
  
  func configure(withObject object: PFObject) {
    captionLabel.text = object["caption"] as? String
    
    if let user = object["user"] as? PFUser {
      let username = user.username
      authorLabel.text = username
      let usernameSplit = username!.split(separator: " ")
      var initials = ""
      if let firstName = usernameSplit.first {
        initials += "\(String(describing: firstName.first ?? "?"))"
      }
      if usernameSplit.count > 1 {
        initials +=  "\(String(describing: usernameSplit[1].first ?? "?"))"
      }
      authorInitials.text = initials.uppercased()
      authorInitialsContainerView.layer.cornerRadius = CGRectGetWidth(authorInitialsContainerView.frame) / 2.0
    }
    
    if let imageFileObject = object["image"] as? PFFileObject {
      self.imageFileObject = imageFileObject
      imageFileObject.getDataInBackground { [unowned self] data, error in
        guard let data = data else { return }
        self.photoImageView.image = UIImage(data: data)
      }
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageFileObject?.cancel()
    photoImageView.image = nil
    captionLabel.text = ""
    authorLabel.text = ""
    authorInitials.text = ""
  }
}
