//
//  ProfileTabsCollectionReusableView.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 31/03/2023.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
