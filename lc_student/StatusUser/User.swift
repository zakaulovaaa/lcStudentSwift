//
//  User.swift
//  lc_student
//
//  Created by Дарья Закаулова on 19.04.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import Foundation

struct User {
    
    var isAuthorized: Bool = false;
    var isVerified: Bool;
    var email: String;
//    var idFrom1c: String?;
    var lastName: String?;
    var firstName: String?;
    var middleName: String?;
    
    init (isAuthorized: Bool, email: String, isVerified: Bool,
          lastName: String, firstName: String, middleName: String) {
        
        self.isAuthorized = isAuthorized
        self.isVerified = isVerified
        self.email = email
        self.lastName = lastName
        self.firstName = firstName
        self.middleName = middleName
        
    }
}

final class UserSettings {
    
    static var email: String! {
        get {
            return UserDefaults.standard.string(forKey: "email")
        }
        set {
            let defaults = UserDefaults.standard
            let key = "email"
            if let email = newValue {
                print("new email = \(email)")
                defaults.set(email, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
}
