//
//  LoginViewController.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 25/03/2023.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameEmailField: UITextField = {
       let field = UITextField()
        field.placeholder = "username or Email "
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
    
    private let loginButtom: UIButton = {
       let buttom = UIButton()
        buttom.setTitle("Login", for: .normal)
        buttom.layer.masksToBounds = true
        buttom.layer.cornerRadius = Constants.cornerRadius
        buttom.backgroundColor = .systemBlue
        buttom.setTitleColor(.white, for: .normal)
        return buttom
    }()
    
    private let termsButtom: UIButton = {
        let button = UIButton()
         button.setTitle("Terms of Serviced", for: .normal)
         button.setTitleColor(.secondaryLabel, for: .normal)
         return button
    }()
    
    private let createAccountButtom: UIButton = {
        let button = UIButton()
         button.setTitle("New User? Create an Account", for: .normal)
         button.setTitleColor(.label, for: .normal)
         return button
    }()
    
    private let privacyButtom: UIButton = {
        let button = UIButton()
         button.setTitle("Privacy Policy", for: .normal)
         button.setTitleColor(.secondaryLabel, for: .normal)
         return button
    }()
    
    private let headerViews: UIView = {
       let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradiente"))
        header.addSubview(backgroundImageView)
        return header
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButtom.addTarget(self, action: #selector(didTapLoginButtom), for: .touchUpInside)
        termsButtom.addTarget(self, action: #selector(didTapTermsButtom), for: .touchUpInside)
        privacyButtom.addTarget(self, action: #selector(didTapPrivacyButtom), for: .touchUpInside)
        createAccountButtom.addTarget(self, action: #selector(didTapCreateAccountButtom), for: .touchUpInside)
        
        
        
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubViews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assingn frame
        headerViews.frame = CGRect(x: 0, y: 0, width: Int(view.width), height: Int(view.height)/3)
        usernameEmailField.frame = CGRect(x: 25, y: Int(headerViews.bottom) + 40, width: Int(view.width) - 50, height: 52)
        passwordField.frame = CGRect(x: 25, y: Int(usernameEmailField.bottom) + 10, width: Int(view.width) - 50, height: 52)
        loginButtom.frame = CGRect(x: 25, y: Int(passwordField.bottom) + 10, width: Int(view.width) - 50, height: 52)
        createAccountButtom.frame = CGRect(x: 25, y: Int(loginButtom.bottom) + 10, width: Int(view.width) - 50, height: 52)
        termsButtom.frame = CGRect(x: 10, y: Int(view.height-view.safeAreaInsets.bottom) - 100, width: Int(view.width)-20, height: 50)
        privacyButtom.frame = CGRect(x: 10, y: Int(view.height-view.safeAreaInsets.bottom) - 50, width: Int(view.width)-20, height: 50)
        
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerViews.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerViews.subviews.first else {
            return
        }
        
        backgroundView.frame = headerViews.bounds
        
        let imageView = UIImageView(image: UIImage(named: "InstagramLetras"))
        headerViews.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerViews.width/4, y: view.safeAreaInsets.top, width: headerViews.width/2, height: headerViews.height - view.safeAreaInsets.top
        )
        
    }
    
    private func addSubViews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButtom)
        view.addSubview(termsButtom)
        view.addSubview(privacyButtom)
        view.addSubview(headerViews)
        view.addSubview(createAccountButtom)
    }
    
    @objc private func didTapLoginButtom() {
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        // login func
        
    }
    
    @objc private func didTapTermsButtom() {
        guard let url = URL(string: "https://about.instagram.com/es-la/blog/announcements/instagram-community-terms-of-use-faqs") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButtom() {
        guard let url = URL(string: "https://about.instagram.com/es-la/blog/announcements/instagram-community-terms-of-use-faqs") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButtom() {
        let vc = RegistrationViewController()
        present(vc, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButtom()
        }
        
        
        
        return true
    }
}
