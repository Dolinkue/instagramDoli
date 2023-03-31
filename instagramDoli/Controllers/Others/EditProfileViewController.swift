//
//  EditProfileViewController.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 25/03/2023.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

final class EditProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[EditProfileFormModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",style: .plain, target: self, action: #selector(didTapCancel))
        tableView.tableHeaderView = createTableHearderView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func configureModel() {
        // name, username, website, bio
        let section1Labels = ["Name", "Username", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(model)
            
        }
        models.append(section1)
        //email, phone, gender
        let section2Labels = ["Email", "Phone", "Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section2.append(model)
            
        }
        models.append(section2)
    }
    
    private func createTableHearderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = header.height/1.5
        let profilePhoto = UIButton(frame: CGRect(x: (view.width-size)/2, y: (header.height-size)/2, width: size, height: size))
        header.addSubview(profilePhoto)
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = size/2
        profilePhoto.addTarget(self, action: #selector(didTapProfilePholo), for: .touchUpInside)
        profilePhoto.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhoto.layer.borderWidth = 1
        profilePhoto.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profilePhoto.tintColor = .label
        return header
    }
    
    
    @objc private func didTapProfilePholo() {
        
    }
    
    // MARK: - Action
    @objc private func didTapSave() {
        // save info to database
        dismiss(animated: true)
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }

}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        
        return "Private Information"
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
}

extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileFormModel) {
        // update the model
        
        print(updateModel.value ?? "nil")
    }
    
    
}
