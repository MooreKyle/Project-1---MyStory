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
    
    
    
//  error reading dependency file '/Users/student/Library/Developer/Xcode/DerivedData/Project_1:_MyStory-ftnoorgoijhnopdkflyilwrzhlbj/Build/Intermediates.noindex/Project 1: MyStory.build/Debug-iphonesimulator/Project 1: MyStory.build/Objects-normal/arm64/Project 1: MyStory-master-emit-module.d': unexpected character in prerequisites
    
    
    
    
    
    
    
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let identifier = segue.identifier {
//            switch identifier {
//            case "SegueToDetail1":
//                // Optional: Pass data to DetailViewController1 if needed
//                break
//            case "SegueToDetail2":
//                // Optional: Pass data to DetailViewController2 if needed
//                break
//            case "SegueToDetail3":
//                // Optional: Pass data to DetailViewController3 if needed
//                break
//            default:
//                break
//            }
//        }
//    }
}
