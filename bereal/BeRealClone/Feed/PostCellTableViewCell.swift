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
  @IBOutlet private weak var authorInitials: UILabel!
  @IBOutlet private weak var authorInitialsContainerView: UIView!
  @IBOutlet private weak var blurView: UIVisualEffectView!
  
  private var postObject: PFObject?
  private var imageFileObject: PFFileObject?
  
  // MARK: Public
  
  func configure(withObject object: PFObject) {
    postObject = object
    updateBlurView()
    updateHeader()
    updateImage()
    updateCaption()
  }
  
  // MARK: Private Methods
  
  private func updateBlurView() {
    let loggedInUser = PFUser.current()!
    let postDateComponents = Calendar.current.dateComponents([.day],
                                                             from: postObject!.createdAt!)
    
    if let lastPostedDate = loggedInUser["lastPostedDate"] as? Date {
      let lastPostedDateComponents = Calendar.current.dateComponents([.day], from: lastPostedDate)
      blurView.isHidden = lastPostedDateComponents.day == postDateComponents.day
    } else {
      blurView.isHidden = false
    }
  }
  
  private func updateHeader() {
    if let user = postObject!["user"] as? PFUser {
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
  }
  
  private func updateImage() {
    if let imageFileObject = postObject!["image"] as? PFFileObject {
      self.imageFileObject = imageFileObject
      imageFileObject.getDataInBackground { [unowned self] data, error in
        guard let data = data else { return }
        self.photoImageView.image = UIImage(data: data)
      }
    }
  }
  
  private func updateCaption() {
    captionLabel.text = postObject!["caption"] as? String
  }
  
  // MARK: Reuse
  
  override func prepareForReuse() {
    super.prepareForReuse()
    postObject = nil
    imageFileObject?.cancel()
    photoImageView.image = nil
    captionLabel.text = ""
    authorLabel.text = ""
    authorInitials.text = ""
    blurView.isHidden = false
  }
}
