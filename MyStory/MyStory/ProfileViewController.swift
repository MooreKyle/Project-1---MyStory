//
//  ViewController.swift
//  MyStory
//
//  Created by Mari Batilando on 11/16/22.
//

import UIKit

class ProfileViewController: UIViewController {

  var selectedContextItem: ContextItem?
  let contextItems = HARDCODED_CONTEXT_ITEMS
  private let kSegueIdentifier = "ShowContextItemDetailSegue"
  
  @IBOutlet weak var contextItem1Button: UIButton!
  @IBOutlet weak var contextItem2Button: UIButton!
  @IBOutlet weak var contextItem3Button: UIButton!
  @IBOutlet weak var profilePhotoImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.frame.height / 2.0
    contextItem1Button.setTitle(contextItems[0].title, for: .normal)
    contextItem2Button.setTitle(contextItems[1].title, for: .normal)
    contextItem3Button.setTitle(contextItems[2].title, for: .normal)
  }

  @IBAction func didTapContextItem1(_ sender: UIButton) {
    selectedContextItem = contextItems[0]
    performSegue(withIdentifier: kSegueIdentifier, sender: nil)
  }
  
  @IBAction func didTapContextItem2(_ sender: UIButton) {
    selectedContextItem = contextItems[1]
    performSegue(withIdentifier: kSegueIdentifier, sender: nil)
  }
  
  @IBAction func didTapContextItem3(_ sender: UIButton) {
    selectedContextItem = contextItems[2]
    performSegue(withIdentifier: kSegueIdentifier, sender: nil)
  }
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    let viewController = segue.destination as! ContextItemViewController
//    viewController.contextItem = selectedContextItem!
  }

