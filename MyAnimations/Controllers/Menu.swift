//
//  Menu.swift
//  MyAnimations
//
//  Created by ruslan on 19.09.2021.
//

import UIKit

final class Menu: UIViewController {
    
    private var myCollectionView: UICollectionView?
    static let animationArray: [MyItemModel] = [
        MyItemModel(name: "Movement", imageName: "arrow.down.right", animationType: .movement)
    ]
    
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
        layout.minimumInteritemSpacing = MyItemSizeConstants.spacing
        layout.minimumLineSpacing = MyItemSizeConstants.spacing
        
        // init and insets
        myCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        myCollectionView?.contentInset = UIEdgeInsets(top: MyItemSizeConstants.spacing,
                                                      left: MyItemSizeConstants.spacing,
                                                      bottom: MyItemSizeConstants.spacing,
                                                      right: MyItemSizeConstants.spacing)
        
        guard let collectionView = myCollectionView else { return }
        collectionView.register(MyItem.self, forCellWithReuseIdentifier: MyItem.identifier)
        
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
        Menu.animationArray.count
    }
    
    // MARK: Cell configuring
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyItem.identifier, for: indexPath) as? MyItem {
            
            cell.setUpData(name: Menu.animationArray[indexPath.row].name,
                           imageName: Menu.animationArray[indexPath.row].imageName)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: - Delegate
    
    // pushing a specific view controller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let type = Menu.animationArray[indexPath.row].animationType
        let vc = BasicAnimations(animationType: type)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Flow layout delegate
    
    // size for each item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: MyItemSizeConstants.side,
                      height: MyItemSizeConstants.side)
    }
}
