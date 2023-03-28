//
//  RegistrationViewController.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 25/03/2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private let usernameField: UITextField = {
       let field = UITextField()
        field.placeholder = "Username..  "
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let emailField: UITextField = {
       let field = UITextField()
        field.placeholder = "Email.. "
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password "
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
       return field
    }()
    
    private let registerButtom: UIButton = {
       let buttom = UIButton()
        buttom.setTitle("Sing Up", for: .normal)
        buttom.layer.masksToBounds = true
        buttom.layer.cornerRadius = Constants.cornerRadius
        buttom.backgroundColor = .systemGreen
        buttom.setTitleColor(.white, for: .normal)
        return buttom
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assingn frame

        usernameField.frame = CGRect(x: 20, y: Int(view.safeAreaInsets.top) + 50, width: Int(view.width) - 50, height: 52)
        emailField.frame = CGRect(x: 20, y: Int(usernameField.bottom) + 10, width: Int(view.width) - 50, height: 52)
        passwordField.frame = CGRect(x: 20, y: Int(emailField.bottom) + 10, width: Int(view.width) - 50, height: 52)
        registerButtom.frame = CGRect(x: 20, y: Int(passwordField.bottom) + 10, width: Int(view.width) - 50, height: 52)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        registerButtom.addTarget(self, action: #selector(ditTapRegister), for: .touchUpInside)
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButtom)
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    @objc private func ditTapRegister() {
        passwordField.resignFirstResponder()
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty, let username = usernameField.text, !username.isEmpty else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { success in
            
            DispatchQueue.main.async {
                if success {
                    //good to go
                }
                else {
                    // failed
                }
            }
        }
    }
    

}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            ditTapRegister()
        }
        return true
    }
}
