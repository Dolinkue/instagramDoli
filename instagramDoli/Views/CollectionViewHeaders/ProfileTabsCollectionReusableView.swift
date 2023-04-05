//
//  ProfileTabsCollectionReusableView.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 31/03/2023.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTagdButtonTab()
}

struct K {
    static let padding:CGFloat = 8
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let tagButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubview(tagButton)
        addSubview(gridButton)
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        tagButton.addTarget(self, action: #selector(didTapTagdButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = height-(K.padding*2)
        let gridBUttonx = ((width/2)-size)/2
        
        gridButton.frame = CGRect(x:gridBUttonx , y: K.padding, width: size, height: size)
        
        tagButton.frame = CGRect(x:gridBUttonx + (width/2), y: K.padding, width: size, height: size)
        
    }
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .systemBlue
        tagButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    
    @objc private func didTapTagdButton() {
        gridButton.tintColor = .lightGray
        tagButton.tintColor = .systemBlue
        delegate?.didTapTagdButtonTab()
    }
    
}

extension ProfileTabsCollectionReusableView: ProfileTabsCollectionReusableViewDelegate {
    func didTapGridButtonTab() {
        
    }
    
    func didTapTagdButtonTab() {
        
    }
    
    
}
