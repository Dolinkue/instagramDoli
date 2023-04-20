//
//  IGFeedPostHearderTableViewCell.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 30/03/2023.
//

import UIKit
import SDWebImage

protocol IGFeedPostHearderTableViewCellDelegate: AnyObject{
    func didTapMoreButton()
}

class IGFeedPostHearderTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostHearderTableViewCell"
    
    weak var delegate: IGFeedPostHearderTableViewCellDelegate?
    
    private let profilePhoto: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let laberl = UILabel()
        laberl.textColor = .label
        laberl.numberOfLines = 1
        laberl.font = .systemFont(ofSize: 18, weight: .medium)
        return laberl
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profilePhoto)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        delegate?.didTapMoreButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: User) {
        // configure Cell
        usernameLabel.text = model.username
        profilePhoto.image = UIImage(systemName: "person.circle")
 //       profilePhoto.sd_setImage(with: model.profilePhoto)
        
    }
    
    override func layoutSubviews() {
        let size = contentView.height-4
        profilePhoto.frame = CGRect(x: 2, y: 2, width: size, height: size)
        profilePhoto.layer.cornerRadius = size/2
        
        moreButton.frame = CGRect(x: contentView.width-size-2, y: 2, width: size, height: size)
        
        usernameLabel.frame = CGRect(x: profilePhoto.rigtht+10, y: 2, width: contentView.width-(size*2)-15, height: contentView.height-4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
            usernameLabel.text = nil
            profilePhoto.image = nil
     //       profilePhoto.sd_setImage(with: model.profilePhoto)
    }

}
