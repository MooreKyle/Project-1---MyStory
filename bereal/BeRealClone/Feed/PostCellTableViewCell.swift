//
//  PostCellTableViewCell.swift
//  BeRealClone
//
//  Created by Mari Batilando on 10/29/22.
//

import UIKit
import ParseSwift
import Alamofire
import AlamofireImage

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
  
  private var post: Post?
  private var imageDataRequest: DataRequest?
  
  // MARK: Public
  
  func configure(withObject object: Post) {
    post = object
    updateBlurView()
    updateHeader()
    updateImage()
    updateCaption()
  }
  
  // MARK: Private Methods
  
  private func updateBlurView() {
    if let loggedInUserLastPostedDate = User.current?.lastPostedDate {
      let numHoursDifference = post!.createdAt!.hours(from: loggedInUserLastPostedDate)
      blurView.isHidden = abs(numHoursDifference) < 24
    } else {
      blurView.isHidden = false
    }
  }
  
  private func updateHeader() {
    if let user = post?.user {
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
    guard let imageFile = post?.image,
          let url = imageFile.url else {
      assertionFailure("Expected image file and url")
      return
    }
    imageDataRequest = AF.request(url).responseImage { [unowned self] response in
      if case .success(let image) = response.result {
        self.photoImageView.image = image
      }
    }
  }
  
  private func updateCaption() {
    captionLabel.text = post?.caption
  }
  
  // MARK: Reuse
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageDataRequest?.cancel()
    post = nil
    photoImageView.image = nil
    captionLabel.text = ""
    authorLabel.text = ""
    authorInitials.text = ""
    blurView.isHidden = false
  }
}
