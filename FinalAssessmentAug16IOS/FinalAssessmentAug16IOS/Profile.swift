//
//  File.swift
//  FinalAssessmentAug16IOS
//
//  Created by Goh Min-Yi on 20/10/2016.
//  Copyright © 2016 dragoh. All rights reserved.
//

import Foundation

enum Gender {
    case male
    case female
}

class Profile {
    var username: String
    var age: Int
    var gender: String
    
    init(username: String, age: Int, gender: Gender) {
        self.username = username
        self.age = age
        switch gender {
        case .male:
            self.gender = "male"
        case .female:
            self.gender = "female"
        }
    }
}
