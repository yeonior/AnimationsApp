//
//  MyItem.swift
//  MyAnimations
//
//  Created by ruslan on 20.09.2021.
//

import UIKit

// MARK: Item size constants
struct MyItemSizeConstants {
    static let spacing: CGFloat = UIScreen.main.bounds.width * 0.05
    static let side: CGFloat = (UIScreen.main.bounds.width - spacing * 3) / 2
}

final class MyItem: UICollectionViewCell {
    
    static let identifier = "MyItem"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // attributes
        contentView.backgroundColor = .tertiarySystemGroupedBackground
//        if traitCollection.userInterfaceStyle == .light {
//            contentView.layer.shadowColor = UIColor.black.cgColor
//        } else {
//            contentView.layer.shadowColor = UIColor.white.cgColor
//        }
        contentView.layer.cornerRadius = 16
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
