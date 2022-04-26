//
//  SignInViewController.swift
//  reg
//
//  Created by anvar on 25/04/22.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet var passwordTF: UITextField!
    
    var hitEmail = ""
    var isEvent = true
    @IBOutlet var hitMail: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hitMail.text = "Sign Up with \(hitEmail)"
    }
    
    @IBAction func signInTapped() {
        signIn()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        isEvent = true
        if segue.identifier == "toValidate" {
            guard let destination = segue.destination as? toValidateViewController else { return }
            destination.password = passwordTF.text ?? ""
        }
    }
    func signIn() {
        let password = passwordTF.text ?? ""
        let email = hitEmail
        
        let params: [String: Any] = ["email" : email,
                                     "password" : password]
        let urlSingIn = "https://app-93b59acf-43d0-422b-a6d0-b28fed8b6c12.cleverapps.io/api/users/sign-in"
        NetworkManager.shared.postRequest(with: params, to: urlSingIn) { result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let json):
                    guard let parsedDictionary = json as? [String: Any] else { return }
                    guard let data = parsedDictionary["message"] as? [String: Any?] else { return }
                    
                    if data["En"] as! String == "Password is incorrect" {
                        self.showAlert(title: "Oooops", message: "Password is incorrect")
                    } else if data["En"] as! String == "Password empty" {
                        self.showAlert(title: "Oooops", message: "Password empty")
                    } else {
                        self.performSegue(withIdentifier: "toValidate", sender: self)
                    }
                    print(json)
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
        }
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
