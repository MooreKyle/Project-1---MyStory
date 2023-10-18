//
//  ViewController.swift
//  Project 1: MyStory
//
//  Created by student on 10/9/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var profilePhotoView: UIImageView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped1(_ sender: Any) {
        performSegue(withIdentifier: "MainSegue", sender: nil)
    }
    @IBAction func buttonTapped2(_ sender: Any) {
        performSegue(withIdentifier: "MainSegue", sender: nil)
    }
    @IBAction func buttonTapped3(_ sender: Any) {
        performSegue(withIdentifier: "MainSegue", sender: nil)
    }
    
    

}
