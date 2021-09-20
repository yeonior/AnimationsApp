//
//  Menu.swift
//  MyAnimations
//
//  Created by ruslan on 19.09.2021.
//

import UIKit

final class Menu: UIViewController {
    
    private var myCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Animations"
        configureCollectionView()
    }
    
    // MARK: - Collection view configuring
    private func configureCollectionView() {
        
        // layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = MyCellSizeConstants.spacing
        layout.minimumLineSpacing = MyCellSizeConstants.spacing
        
        // init and insets
        myCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        myCollectionView?.contentInset = UIEdgeInsets(top: MyCellSizeConstants.spacing,
                                                      left: MyCellSizeConstants.spacing,
                                                      bottom: MyCellSizeConstants.spacing,
                                                      right: MyCellSizeConstants.spacing)
        
        guard let collectionView = myCollectionView else { return }
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.identifier)
        
        // protocols
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // attributes
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundView = UIView()
        collectionView.backgroundView?.backgroundColor = .systemBackground
        
        // adding
        view.addSubview(collectionView)
    }
}

// MARK: - Collection view protocols

extension Menu: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Data source
    
    // number of section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    // MARK: Cell configuring
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.identifier, for: indexPath) as? MyCell {
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: - Flow layout delegate
    
    // size for each item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: MyCellSizeConstants.itemSide,
                      height: MyCellSizeConstants.itemSide)
    }
}
