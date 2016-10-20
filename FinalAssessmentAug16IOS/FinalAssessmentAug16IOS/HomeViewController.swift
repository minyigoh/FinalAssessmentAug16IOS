//
//  ViewController.swift
//  FinalAssessmentAug16IOS
//
//  Created by Goh Min-Yi on 20/10/2016.
//  Copyright © 2016 dragoh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    var listViewController: ListViewController?
    
    var profiles = [Profile]()
    var filteredProfiles = [Profile]()
    var currentProfile: Profile?
    var index = 0
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = ""
        ageLabel.text = ""
        listViewController = self.tabBarController?.viewControllers?[1].childViewControllers.first as? ListViewController
        self.retrieveProfilesFromFirebase()
    }
    
    func retrieveProfilesFromFirebase() {
        let user = FIRAuth.auth()!.currentUser!
        FIRDatabase.database().reference().child("profiles").observe(.childAdded, with: { (snapshot) in
            let key = snapshot.key
            
            if key != user.uid {
                FIRDatabase.database().reference().child("profiles").child(key).observe(.value, with: {(profileSnapshot) in
                    let profileDict = profileSnapshot.value as! [String: String]
                    let username = profileDict["username"]! as String
                    let age = profileDict["age"]! as String
                    let gender = profileDict["gender"]! as String
                    let profile = Profile(username: username, age: age, gender: gender)
                    self.profiles.append(profile)
                    self.filteredProfiles = self.profiles
                    self.currentProfile = self.filteredProfiles[0]
                    self.usernameLabel.text = self.currentProfile!.username
                    self.ageLabel.text = self.currentProfile!.age
                })
            }
        })
    }
    
    @IBAction func onMaleButtonPressed(_ sender: UIButton) {
        filterMaleOnly()
        index = 0
        currentProfile = filteredProfiles[0]
        usernameLabel.text = currentProfile!.username
        ageLabel.text = String(describing: currentProfile!.age)
    }
    
    @IBAction func onFemaleButtonPressed(_ sender: UIButton) {
        filterFemaleOnly()
        index = 0
        currentProfile = filteredProfiles[0]
        usernameLabel.text = currentProfile!.username
        ageLabel.text = String(describing: currentProfile!.age)
    }
    
    
    func filterFemaleOnly() {
        filteredProfiles = self.profiles.filter({ $0.gender == "female"})
    }
    
    func filterMaleOnly() {
        filteredProfiles = self.profiles.filter({ $0.gender == "male"})
    }
    
    @IBAction func swipeGesture(recognizer: UISwipeGestureRecognizer) {
        switch recognizer.direction {
        case UISwipeGestureRecognizerDirection.right:
            listViewController?.matchedProfiles.append(currentProfile!)
            listViewController?.tableView?.reloadData()
            index += 1
            if index >= filteredProfiles.count {
                let alertController = UIAlertController(title: "NO MORE PROFILES TO SHOW", message: nil, preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "LIKED", message: nil, preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.currentProfile = self.filteredProfiles[self.index]
                    self.usernameLabel.text = self.currentProfile!.username
                    self.ageLabel.text = self.currentProfile!.age
                })
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
        case UISwipeGestureRecognizerDirection.left:
            index += 1
            if index >= filteredProfiles.count {
                let alertController = UIAlertController(title: "NO MORE PROFILES TO SHOW", message: nil, preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "DISLIKED", message: nil, preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.currentProfile = self.filteredProfiles[self.index]
                    self.usernameLabel.text = self.currentProfile!.username
                    self.ageLabel.text = self.currentProfile!.age
                })
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
        default:
            return
        }
    }
}

