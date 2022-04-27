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
    @IBOutlet var hitMail: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hitMail.text = "Sign Up with \(hitEmail)"
    }
    
    @IBAction func signInTapped() {
        signIn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "validateVC" {
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
                    print(json)
                    guard let parsedDictionary = json as? [String: Any] else { return }
                    guard let data = parsedDictionary["message"] as? [String: Any?] else { return }
                    
                    if data["En"] as! String != "Password is incorrect", data["En"] as! String != "Password empty" {
                        self.performSegue(withIdentifier: "validateVC", sender: self)
                    } else  {
                        self.showAlert(title: "Ooops", message: "Password is incorrect!")
                    }
                case .failure(let error):
                    print(error)
                    
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
