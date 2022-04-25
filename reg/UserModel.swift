//
//  UserModel.swift
//  reg
//
//  Created by anvar on 25/04/22.
//

import Foundation


struct User: Codable {
    let userName:String
    let email:String
    let password:String
}
//    func saveUser (userName:String,email:String, password:String) {
//        let user = User(userName: userName, email: email, password: password)
//        users.insert(user, at: 0)
//    }

//
//let encoder = JSONEncoder()
//if let encoded = try? encoder.encode([User].self) {
//    let defaults = UserDefaults.standard
//    defaults.set(encoded, forKey: "SavedPerson")
//}
