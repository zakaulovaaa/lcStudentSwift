//
//  User.swift
//  lc_student
//
//  Created by Дарья Закаулова on 19.04.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import Foundation

class Group: NSObject, NSCoding {
    var name: String
    var idZK1C: String
    var degreeProgram: String
    var faculty: String
    
    init(name: String, id: String, degreeProgram: String, faculty: String) {
        self.name = name
        self.idZK1C = id
        self.degreeProgram = degreeProgram
        self.faculty = faculty
    }
    func encode(with coder: NSCoder) {
        coder.encode( name, forKey: "name" )
        coder.encode( idZK1C, forKey: "idZK1C" )
        coder.encode( degreeProgram, forKey: "degreeProgram" )
        coder.encode( faculty, forKey: "faculty" )
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        idZK1C = coder.decodeObject(forKey: "idZK1C") as? String ?? ""
        degreeProgram = coder.decodeObject(forKey: "degreeProgram") as? String ?? ""
        faculty = coder.decodeObject(forKey: "faculty") as? String ?? ""
    }
    
    
}

class UserModel: NSObject, NSCoding {
    
    var isVerified: Bool;
    var email: String;
    var lastName: String?;
    var firstName: String?;
    var middleName: String?;
    var studentsGroup: [ Group ]?;
    
    init ( email: String, isVerified: Bool,
           lastName: String, firstName: String, middleName: String,
           studentsGroup: [ Group ] ) {
        
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
        studentsGroup = coder.decodeObject(forKey: "studentsGroup") as? [ Group ] ?? []
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
