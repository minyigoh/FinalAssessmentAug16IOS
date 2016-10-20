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
        listViewController = self.tabBarController?.viewControllers?[1] as? ListViewController
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
    
//    func preloadUserDatabase() {
//        let user1 = Profile(username: "Isabelle", age: "28", gender: "female")
//        let user2 = Profile(username: "Melissa", age: "25", gender: "female")
//        let user3 = Profile(username: "Bernard", age: "29", gender: "male")
//        let user4 = Profile(username: "Maya", age: "23", gender: "female")
//        let user5 = Profile(username: "John", age: "26", gender: "male")
//        
//        uploadToFirebase(username: user1.username, age: user1.age, gender: user1.gender)
//        uploadToFirebase(username: user2.username, age: user2.age, gender: user2.gender)
//        uploadToFirebase(username: user3.username, age: user3.age, gender: user3.gender)
//        uploadToFirebase(username: user4.username, age: user4.age, gender: user4.gender)
//        uploadToFirebase(username: user5.username, age: user5.age, gender: user5.gender)
//    }
//    
//    func uploadToFirebase(username: String, age: String, gender: String) {
//        let profileDict = ["username": username,
//                           "age": age,
//                           "gender": gender]
//        let profileRef = FIRDatabase.database().reference().child("profiles").childByAutoId()
//        profileRef.setValue(profileDict)
//        
//        print("test")
//    }
    
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
            print("swiped to the right")
            index += 1
            if index >= filteredProfiles.count {
                print("No more profiles to show")
            } else {
                currentProfile = filteredProfiles[index]
                usernameLabel.text = currentProfile!.username
                ageLabel.text = String(describing: currentProfile!.age)
            }
        case UISwipeGestureRecognizerDirection.left:
            print("swiped to the left")
            index += 1
            if index >= filteredProfiles.count {
                print("No more profiles to show")
            } else {
                currentProfile = filteredProfiles[index]
                usernameLabel.text = currentProfile!.username
                ageLabel.text = String(describing: currentProfile!.age)
            }
        default:
            return
        }
    }
}

