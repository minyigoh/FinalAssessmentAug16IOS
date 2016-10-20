//
//  ViewController.swift
//  FinalAssessmentAug16IOS
//
//  Created by Goh Min-Yi on 20/10/2016.
//  Copyright © 2016 dragoh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var listViewController: ListViewController?
    
    var profiles = [Profile]()
    var currentProfile: Profile?
    var index = 0
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listViewController = self.tabBarController?.viewControllers?[1] as? ListViewController
        
        preloadUserDatabase()
        currentProfile = profiles[0]
        usernameLabel.text = currentProfile!.username
        ageLabel.text = String(describing: currentProfile!.age)
    }
    
    func preloadUserDatabase() {
        let user1 = Profile(username: "Isabelle", age: 28, gender: .female)
        let user2 = Profile(username: "Melissa", age: 25, gender: .female)
        let user3 = Profile(username: "Bernard", age: 29, gender: .male)
        let user4 = Profile(username: "Maya", age: 23, gender: .female)
        let user5 = Profile(username: "John", age: 26, gender: .male)
        profiles.append(user1)
        profiles.append(user2)
        profiles.append(user3)
        profiles.append(user4)
        profiles.append(user5)
    }
    
    func filterFemaleOnly() {
        let femaleProfiles: Profile = self.profiles.filter({ (profile: Profile) -> Bool in
            switch profile.gender {
            case "female":
                return profile
            default:
                return false
            }
        })
    }
    
    @IBAction func swipeGesture(recognizer: UISwipeGestureRecognizer) {
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.right:
            listViewController?.matchedProfiles.append(currentProfile!)
            listViewController?.tableView?.reloadData()
            print("swiped to the right")
            index += 1
            if index >= profiles.count {
                print("No more profiles to show")
            } else {
                currentProfile = profiles[index]
                usernameLabel.text = currentProfile!.username
                ageLabel.text = String(describing: currentProfile!.age)
            }
        case UISwipeGestureRecognizerDirection.left:
            print("swiped to the left")
            index += 1
            if index >= profiles.count {
                print("No more profiles to show")
            } else {
                currentProfile = profiles[index]
                usernameLabel.text = currentProfile!.username
                ageLabel.text = String(describing: currentProfile!.age)
            }
        default:
            return
        }
    }
}

