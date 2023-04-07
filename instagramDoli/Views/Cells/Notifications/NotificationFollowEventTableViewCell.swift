//
//  NotificationFollowEventTableViewCell.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 07/04/2023.
//

import UIKit


protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didtapFollowUnFollowButton(model: String)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
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

        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("follow", for: .normal)

        return button
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(lable)
        contentView.addSubview(followButton)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    public func configure(with model: String) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        lable.text = nil
        profileImageView.image = nil
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
