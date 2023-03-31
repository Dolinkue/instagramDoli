//
//  SettingViewController.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 25/03/2023.
//
import SafariServices
import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}



final class SettingViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func didTapLogOut() {
        
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut { success in
                DispatchQueue.main.async {
                    if success {
                        // logIn view controller
                        let loginVc = LoginViewController()
                        loginVc.modalPresentationStyle = .fullScreen
                        self.present(loginVc, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                    else {
                        // error
                        
                    }
                }

            }
        }))
        present(actionSheet, animated: true)
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
    }
    
    private func didTapInviteFriends() {
        // show share sheet
    }
    
    private func didTapSaveOriginalPost() {
        
    }
    
    private func openURL(type: SettingUrlType) {
        
        let urlString: String
        switch type {
        case .terms: urlString = "https://about.instagram.com/es-la/blog/announcements/instagram-community-terms-of-use-faqs"
        case .policy: urlString = "https://about.instagram.com/es-la/blog/announcements/instagram-community-terms-of-use-faqs"
        case .help: urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    enum SettingUrlType {
        case terms
        case policy
        case help
    }
    
    private func configureModel() {
        
        data.append([SettingCellModel(title: "Edit Profile", handler: {
            [weak self] in self?.didTapEditProfile()
        }),SettingCellModel(title: "Invite friends", handler: {
            [weak self] in self?.didTapInviteFriends()
        }),SettingCellModel(title: "Save Original Posts", handler: {
            [weak self] in self?.didTapSaveOriginalPost()
        })])
        
        data.append([SettingCellModel(title: "Terms of Service", handler: {
            [weak self] in self?.openURL(type: .terms)
        })])
        
        data.append([SettingCellModel(title: "Privacy Policy", handler: {
            [weak self] in self?.openURL(type: .policy)
        })])
        
        data.append([SettingCellModel(title: "Help / Feedback", handler: {
            [weak self] in self?.openURL(type: .help)
        })])
        
        data.append([SettingCellModel(title: "Log Out", handler: {
            [weak self] in self?.didTapLogOut()
        })])
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
    
}
