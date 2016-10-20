//
//  ViewController.swift
//  FinalAssessmentAug16IOS
//
//  Created by Goh Min-Yi on 20/10/2016.
//  Copyright © 2016 dragoh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var profiles = [Profile]()
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user1 = Profile(username: "Isabelle", age: 28)
        let user2 = Profile(username: "Melissa", age: 25)
        let user3 = Profile(username: "Maya", age: 23)
        profiles.append(user1)
        profiles.append(user2)
        profiles.append(user3)
        let currentProfile = profiles[0]
        usernameLabel.text = currentProfile.username
        ageLabel.text = String(currentProfile.age)
    }
    
    @IBAction func swipeGesture(recognizer: UISwipeGestureRecognizer) {
        var index = 1
        let currentProfile = profiles[index]
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.right:
            print("swiped to the right")
            index += 1
            
        case UISwipeGestureRecognizerDirection.left:
            print("swiped to the left")
            index += 1
            
        default:
            return
        }
    }
}

