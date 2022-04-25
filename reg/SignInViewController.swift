//
//  SignInViewController.swift
//  reg
//
//  Created by anvar on 25/04/22.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet var passwordTF: UITextField!
    var emails = ""
    var hitEmail = ""
    @IBOutlet var hitMail: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hitMail.text = "Sign Up with \(hitEmail)"
    }
    
    
    @IBAction func signInTapped() {
        let password = passwordTF.text ?? ""
        let user = findUserData(password: password)
        
        user?.password == password
        ? performSegue(withIdentifier: "endVC", sender: self)
        : showAlert(title: "Oooops", message: "Неправильный пароль!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endVC" {
            guard let destination = segue.destination as? toValidateViewController else { return }
            destination.password = passwordTF.text ?? ""
        }
    }
    
    private func findUserData(password:String) -> User? {
        let dataBase = DataBase.shared.users
        print(dataBase)
        for user in dataBase {
            if user.password == password {
                return user
            }
        }
        return nil
    }
}

extension SignInViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.passwordTF.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
        
    }
}
