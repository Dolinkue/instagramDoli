//
//  IGFeedPostActionsTableViewCell.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 30/03/2023.
//

import UIKit

class IGFeedPostActionsTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostActionsTableViewCell"
    
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // configure Cell
        
    }
    
    override func layoutSubviews() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
