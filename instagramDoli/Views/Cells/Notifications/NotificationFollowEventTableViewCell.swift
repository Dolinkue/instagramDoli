//
//  NotificationFollowEventTableViewCell.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 07/04/2023.
//

import UIKit
import SDWebImage


protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didtapFollowUnFollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let lable: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@moro Started follow"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("follow", for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(lable)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        configureForFollow()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didtapFollowUnFollowButton(model: model)
    }

    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            // configure button
            switch state {
            case .following:
                //show unfollow button
                configureForFollow()
            case .not_following:
                // show follow button
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
            }
            break
        }
        lable.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        lable.text = nil
        profileImageView.image = nil
    }
    
    func configureForFollow() {
        followButton.setTitle("UnFollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let size = 100
        let buttHeitght: CGFloat = 40
        followButton.frame = CGRect(x: contentView.width-5-CGFloat(size), y: (contentView.height-44)/2, width: 100, height: buttHeitght)
        
        lable.frame = CGRect(x: profileImageView.rigtht+5, y: 0 , width: contentView.width-CGFloat(size)-profileImageView.width-16, height: contentView.height)
    }
}
