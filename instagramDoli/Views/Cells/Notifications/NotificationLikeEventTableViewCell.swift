//
//  NotificationLikeEventTableViewCell.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 07/04/2023.
//

import UIKit
import SDWebImage


protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didtapRelatedPostButton(model: UserNotification)
}

final class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let lable: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@mela like your photo"
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)

        return button
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(lable)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapPostButton() {
        guard let model = model else {
            return
        }
        
        delegate?.didtapRelatedPostButton(model: model)
    }
    

    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal)
        case .follow:
            break
        }
        lable.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        lable.text = nil
        profileImageView.image = nil
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let size = contentView.height-4
        postButton.frame = CGRect(x: contentView.width-5-size, y: 2, width: size, height: size)
        
        lable.frame = CGRect(x: profileImageView.rigtht+5, y: 0 , width: contentView.width-size-profileImageView.width-16, height: contentView.height)
        
    }
}

