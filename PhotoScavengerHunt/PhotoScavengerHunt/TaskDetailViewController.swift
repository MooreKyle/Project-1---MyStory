//
//  TaskDetailViewController.swift
//  PhotoScavengerHunt
//
//  Created by Mari Batilando on 11/15/22.
//

import UIKit
import MapKit
import PhotosUI

class TaskDetailViewController: UIViewController, PHPickerViewControllerDelegate, MKMapViewDelegate {
  
  @IBOutlet weak var taskStatusImageView: UIImageView!
  @IBOutlet weak var taskTitleLabel: UILabel!
  @IBOutlet weak var taskDescriptionLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var attachPhotoButton: UIButton!
  var task: Task!
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.register(PhotoAnnotationView.self,
                     forAnnotationViewWithReuseIdentifier: PhotoAnnotationView.identifier)
    configure(with: task)
  }
  
  // MARK: IBActions
  
  @IBAction func didTapAttachPhotoButton(_ sender: UIButton) {
    if PHPhotoLibrary.authorizationStatus(for: .readWrite) != .authorized {
      requestAuthorization()
    } else {
      openPhotoPicker()
    }
  }
  
  // MARK: Private
  
  private func requestAuthorization() {
    PHPhotoLibrary.requestAuthorization { [unowned self] newStatus in
      switch newStatus {
      case .authorized:
        self.openPhotoPicker()
      case .denied, .notDetermined, .restricted, .limited:
        assertionFailure("Should have authorized access")
      default:
        break
      }
    }
  }
  
  private func configure(with task: Task) {
    navigationItem.title = task.title
    taskTitleLabel.text = task.title
    taskDescriptionLabel.text = task.description
    taskStatusImageView.image = UIImage(named: task.isCompleted ? "done" : "not-done")?.withRenderingMode(.alwaysTemplate)
    taskStatusImageView.tintColor = task.isCompleted ? .systemGreen : .systemRed
    attachPhotoButton.isHidden = task.isCompleted
    if task.isCompleted {
      addMapAnnotation()
    }
  }
  
  private func openPhotoPicker() {
    var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
    config.filter = .images
    config.selectionLimit = 1
    config.preferredAssetRepresentationMode = .current
    let controller = PHPickerViewController(configuration: config)
    controller.delegate = self
    present(controller, animated: true)
  }
  
  private func addMapAnnotation() {
    let coordinate =
    CLLocationCoordinate2D(latitude: task.imageLocation!.coordinate.latitude,
                           longitude: task.imageLocation!.coordinate.longitude)
    let restaurantRegion = MKCoordinateRegion(center: coordinate,
                                              span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                     longitudeDelta: 0.01))
    self.mapView.setRegion(restaurantRegion, animated: true)
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    self.mapView.addAnnotation(annotation)
  }
  
  // MARK: PHPickerViewControllerDelegate
  
  func picker(_ picker: PHPickerViewController,
              didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)
    let imageResult = results.first
    guard let assetID = imageResult?.assetIdentifier,
          let itemProvider = imageResult?.itemProvider,
          itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
    guard let assetLocation = PHAsset.fetchAssets(withLocalIdentifiers: [assetID], options: nil).firstObject?.location else { return }
    itemProvider.loadObject(ofClass: UIImage.self) { object, error in
      guard let image = object as? UIImage else { return }
      DispatchQueue.main.async { [unowned self] in
        self.task.setImage(image, with: assetLocation)
        self.configure(with: self.task)
        self.addMapAnnotation()
      }
    }
  }
  
  // MARK: MKMapViewDelegate
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: PhotoAnnotationView.identifier,
                                                        for: annotation) as! PhotoAnnotationView
    pinView = PhotoAnnotationView(annotation: annotation, reuseIdentifier: PhotoAnnotationView.identifier)
    pinView.configure(with: task)
    return pinView
  }
}
