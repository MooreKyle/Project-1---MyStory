//
//  PhotoUploadViewController.swift
//  BeRealClone
//
//  Created by Mari Batilando on 10/27/22.
//

import UIKit
import PhotosUI
import Parse

class PhotoUploadViewController: UIViewController, PHPickerViewControllerDelegate {
  
  @IBOutlet weak var selectPhotoButton: UIButton!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var captionTextField: UITextField!
  @IBOutlet weak var postButton: UIButton!
  private var photoImageChosen: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.leftBarButtonItem?.title = ""
  }
  
  @IBAction func selectPhotoButtonTapped(_ sender: UIButton) {
    var config = PHPickerConfiguration()
    config.filter = .images
    config.selectionLimit = 1
    config.preferredAssetRepresentationMode = .current
    let controller = PHPickerViewController(configuration: config)
    controller.delegate = self
    present(controller, animated: true)
  }
  
  @IBAction func postPhotoButtonTapped(_ sender: UIButton) {
    guard let photoImageChosen = self.photoImageChosen else { return }
    let post = PFObject(className: "Post")
    let imageFileObject = PFFileObject(name: "photo.jpg",
                                       data: photoImageChosen.jpegData(compressionQuality: 0.1)!)
    post["image"] = imageFileObject
    post["caption"] = captionTextField.text
    post["user"] = PFUser.current()
    post.saveInBackground { [unowned self] isSuccess, error in
      guard isSuccess else {
        print("not successful")
        return
      }
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  func picker(_ picker: PHPickerViewController,
              didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)
    guard let itemProvider = results.first?.itemProvider,
          itemProvider.canLoadObject(ofClass: UIImage.self) else {
      return
    }
    
    itemProvider.loadObject(ofClass: UIImage.self) { object, error in
      guard let image = object as? UIImage else { return }
      DispatchQueue.main.async { [unowned self] in
        self.photoImageChosen = image
        self.photoImageView.image = image
      }
    }
  }
}
