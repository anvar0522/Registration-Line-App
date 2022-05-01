//
//  SignUpViewController.swift
//  reg
//
//  Created by anvar on 25/04/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var nameTf: UITextField!
    var emails = ""
    
    override func viewWillAppear(_ animated: Bool) {
        emailLabel.text = "For \( emails)"
    }
    
    @IBAction func signUpTapped() {
        
        if passwordTF.text == "" || nameTf.text == "" {
            showAlert(title: "Oooops", message: "Корректно введите все поля!")
        } else {
            signUp()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logOut" {
            guard let destination = segue.destination as? LogOutViewController else { return }
            destination.toValidate = emailLabel.text ?? ""
        }
    }
    
    private func signUp() {
        performSegue(withIdentifier: "logOut", sender: self)
        let password = passwordTF.text ?? ""
        let name = nameTf.text ?? ""
        let email = emails
        
        let json: [String: Any] = ["name" : name,
                                   "email" : email,
                                   "password" : password]
        let urlSignUp = "someurl"
        NetworkManager.shared.postRequest(with: json, to: urlSignUp) { result in
            switch result {
            case .success(let json):
                print(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SignUpViewController{
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
