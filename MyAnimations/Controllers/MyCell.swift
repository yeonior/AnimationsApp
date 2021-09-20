//
//  MyCell.swift
//  MyAnimations
//
//  Created by ruslan on 20.09.2021.
//

import UIKit

// MARK: Cell size constants
struct MyCellSizeConstants {
    static let spacing: CGFloat = UIScreen.main.bounds.width * 0.05
    static let itemSide: CGFloat = (UIScreen.main.bounds.width - spacing * 3) / 2
}

final class MyCell: UICollectionViewCell {
    
    static let identifier = "MyCell"
    
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
