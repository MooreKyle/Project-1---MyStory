//
//  PostCellTableViewCell.swift
//  BeRealClone
//
//  Created by Mari Batilando on 10/29/22.
//

import UIKit
import Parse

extension Date {
  func hours(from date: Date) -> Int {
      return Calendar.current.dateComponents([.hour],
                                             from: date,
                                             to: self).hour ?? 0
  }
}

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
    if let loggedInUserLastPostedDate = PFUser.current()!["lastPostedDate"] as? Date {
      let numHoursDifference = postObject!.createdAt!.hours(from: loggedInUserLastPostedDate)
      blurView.isHidden = abs(numHoursDifference) < 24
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
    imageFileObject?.cancel()
    postObject = nil
    photoImageView.image = nil
    captionLabel.text = ""
    authorLabel.text = ""
    authorInitials.text = ""
    blurView.isHidden = false
  }
}
