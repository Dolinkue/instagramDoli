//
//  NotificationLikeEventTableViewCell.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 07/04/2023.
//

import UIKit


protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didtapRelatedPostButton(model: String)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
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
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("follow", for: .normal)

        return button
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(lable)
        contentView.addSubview(postButton)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    public func configure(with model: String) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        lable.text = nil
        profileImageView.image = nil
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

