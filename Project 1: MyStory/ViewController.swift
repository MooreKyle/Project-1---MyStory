//
//  ViewController.swift
//  Project 1: MyStory
//
//  Created by student on 10/9/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func button1Tapped(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueToDetail1", sender: self)
    }

    @IBAction func button2Tapped(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueToDetail2", sender: self)
    }

    @IBAction func button3Tapped(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueToDetail3", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "SegueToDetail1":
                // Optional: Pass data to DetailViewController1 if needed
                break
            case "SegueToDetail2":
                // Optional: Pass data to DetailViewController2 if needed
                break
            case "SegueToDetail3":
                // Optional: Pass data to DetailViewController3 if needed
                break
            default:
                break
            }
        }
    }
}
