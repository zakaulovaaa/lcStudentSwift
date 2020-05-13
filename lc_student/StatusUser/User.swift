//
//  User.swift
//  lc_student
//
//  Created by Дарья Закаулова on 19.04.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import Foundation


class UserModel: NSObject, NSCoding {
    
    var isVerified: Bool;
    var email: String;
    var lastName: String?;
    var firstName: String?;
    var middleName: String?;
    var studentsGroup: [ String ];
    
    init ( email: String, isVerified: Bool,
           lastName: String, firstName: String, middleName: String,
           studentsGroup: [ String ]) {
        
        self.isVerified = isVerified
        self.email = email
        self.lastName = lastName
        self.firstName = firstName
        self.middleName = middleName
        self.studentsGroup = studentsGroup
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode( isVerified, forKey: "isVerified" )
        coder.encode( email, forKey: "email" )
        coder.encode( lastName, forKey: "lastName" )
        coder.encode( firstName, forKey: "firstName" )
        coder.encode( middleName, forKey: "middleName" )
        coder.encode( studentsGroup, forKey: "studentsGroup" )
    }
    
    required init?(coder: NSCoder) {
        isVerified = coder.decodeBool(forKey: "isVerified")
        email = coder.decodeObject(forKey: "email") as? String ?? ""
        lastName = coder.decodeObject(forKey: "lastName") as? String ?? ""
        firstName = coder.decodeObject(forKey: "firstName") as? String ?? ""
        middleName = coder.decodeObject(forKey: "middleName") as? String ?? ""
        studentsGroup = coder.decodeObject(forKey: "studentsGroup") as? [ String ] ?? []
    }
}


final class UserSettings {
    
    private enum SettingsKeys: String {
        case userModel
    }
    
    static var userModel: UserModel! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.userModel.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData( savedData ) as? UserModel else {
                return nil
            }
            return decodedModel
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userModel.rawValue
            if let userModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
                    defaults.set( savedData, forKey: key )
                }
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    
    
    
}
