//
//  LoginViewController.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 25/03/2023.
//

import UIKit


class LoginViewController: UIViewController {
    
    private let usernameEmailField: UITextField = {
       return UITextField()
    }()
    
    private let passwordField: UITextField = {
       return UITextField()
    }()
    
    private let loginButtom: UIButton = {
       return UIButton()
    }()
    
    private let termsButtom: UIButton = {
       return UIButton()
    }()
    
    private let createAccountButtom: UIButton = {
       return UIButton()
    }()
    
    private let privacyButtom: UIButton = {
       return UIButton()
    }()
    
    private let headerViews: UIView = {
       return UIView()
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assingn frame
        
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
    
    @objc private func didTapLoginButtom() {}
    
    @objc private func didTapTermsButtom() {}
    
    @objc private func didTapPrivacyButtom() {}
    
    @objc private func didTapCreateAccountButtom() {}

}
