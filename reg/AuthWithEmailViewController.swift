//
//  AuthWithEmailViewController.swift
//  reg
//
//  Created by anvar on 25/04/22.
//

import UIKit

class AuthWithEmailViewController: UIViewController {
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var alertLabel: UILabel!
    
    
    @IBAction func emailTapped() {
        if isValidEmail(emailTF.text!) == true {
            alertLabel.text = "Email is Valid"
            alertLabel.textColor = .systemGreen
        } else {
            alertLabel.text = "Wrong format"
            alertLabel.textColor = .systemRed
        }
    }
    
    @IBAction func authWithEmail(_ sender: UIButton) {
        
        if isValidEmail(emailTF.text!) == false {
            showAlert(title: "Ooooops", message: "Введите корректный почтовый адрес!")
        } else {
            findEmail()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUp" {
            guard let destination = segue.destination as? SignUpViewController else { return }
            destination.emails = emailTF.text ?? ""
        } else   {
            guard let destination = segue.destination as? SignInViewController else { return }
            destination.hitEmail = emailTF.text ?? ""
        }
    }
    
    private func findEmail() {
        let mail = emailTF.text ?? ""
        
        let json: [String: Any] = ["email" : mail]
        let urlSearchEmail = "https://app-93b59acf-43d0-422b-a6d0-b28fed8b6c12.cleverapps.io/api/users/search_email"
        NetworkManager.shared.postRequest(with: json, to: urlSearchEmail) { result in
            switch result {
            case .success(let passed):
                print(passed)
                if passed as! [String : String] == ["message": "no"] {
                    DispatchQueue.main.async {[weak self] in
                        self?.performSegue(withIdentifier: "signUp", sender: self)
                    }
                } else {
                    DispatchQueue.main.async {[weak self] in
                        self?.performSegue(withIdentifier: "signIn", sender: self)
                    }
                }
            case .failure(_):
                self.showAlert(title: "Oooops", message: "Something went wrong, contact with our support")
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
        
    }
}

extension AuthWithEmailViewController: UITextFieldDelegate {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.emailTF.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}


