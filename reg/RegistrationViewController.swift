//
//  RegistrationViewController.swift
//  reg
//
//  Created by anvar on 25/04/22.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBAction func unwindFromLogOut(for segue: UIStoryboardSegue) {
    }
    @IBAction func unwindFromValidateVC(for segue: UIStoryboardSegue) {
        
    }
    
    

    func findUserData(mail:String) -> User? {
        let dataBase = DataBase.shared.users
print(dataBase)
        for user in dataBase {
            if user.email == mail {
                return user
            }
        }
        return nil
    }

}
