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
    
    // MARK: Image view configuring
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "nosign")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: Name label configuring
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "n/a"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // adding subviews
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        // attributes
        contentView.backgroundColor = .tertiarySystemGroupedBackground
        contentView.layer.cornerRadius = 16
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // constraints
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // setting up data
    public func setUpData(name: String, imageName: String) {
        nameLabel.text = name
        imageView.image = UIImage(systemName: imageName)
    }
}
