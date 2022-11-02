//
//  PhotoUploadViewController.swift
//  BeRealClone
//
//  Created by Mari Batilando on 10/27/22.
//

import UIKit
import PhotosUI
import Parse

class PhotoUploadViewController: UIViewController,
                                 PHPickerViewControllerDelegate,
                                 UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
  @IBOutlet private weak var selectPhotoButton: UIButton!
  @IBOutlet private weak var photoImageView: UIImageView!
  @IBOutlet private weak var captionTextField: UITextField!
  private var photoImageChosen: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    selectPhotoButton.setTitle(isUnit5 ? "Select Photo" : "Open Camera", for: .normal)
  }
  
  // MARK: IBActions
  
  @IBAction func selectPhotoButtonTapped(_ sender: UIButton) {
    if isUnit5 {
      openPhotoPicker()
    } else {
      openCamera()
    }
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
  
  // MARK: Private Methods
  
  private func openCamera() {
    if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
      let imagePicker =  UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .camera
      self.present(imagePicker, animated: true, completion: nil)
    } else {
      let alert  = UIAlertController(title: "Warning",
                                     message: "You don't have camera",
                                     preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  private func openPhotoPicker() {
    var config = PHPickerConfiguration()
    config.filter = .images
    config.selectionLimit = 1
    config.preferredAssetRepresentationMode = .current
    let controller = PHPickerViewController(configuration: config)
    controller.delegate = self
    present(controller, animated: true)
  }
  
  // MARK: PHPickerViewControllerDelegate
  
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
  
  // MARK: UIImagePickerControllerDelegate
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let imageChosen = info[.originalImage] as? UIImage else { return }
    photoImageChosen = imageChosen
    photoImageView.image = imageChosen
    picker.dismiss(animated: true)
  }
}
