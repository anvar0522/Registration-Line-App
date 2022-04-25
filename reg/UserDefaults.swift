//
//  UserDefaults.swift
//  reg
//
//  Created by anvar on 25/04/22.
//

import Foundation

class DataBase {
    
    static let shared = DataBase()
    
    enum SettingKeys:String {
        case users
    }

    let defaults = UserDefaults.standard
    let userKey = SettingKeys.users.rawValue


    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }

        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    func saveUser (userName:String,email:String, password:String) {
        let user = User(userName: userName, email: email, password: password)
        users.insert(user, at: 0)
    }
    
}
