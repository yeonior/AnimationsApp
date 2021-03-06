//
//  Menu.swift
//  MyAnimations
//
//  Created by ruslan on 19.09.2021.
//

import UIKit

final class Menu: UIViewController {
    
    private var myCollectionView: UICollectionView?
    private var firstAppearanceKey = false
    static let animationArray: [MyItemModel] = [
        MyItemModel(name: "Appearing", imageName: "rays", animationType: .appearing),
        MyItemModel(name: "Coloring", imageName: "circle.righthalf.fill", animationType: .coloring),
        MyItemModel(name: "Centering", imageName: "arrow.down.forward.and.arrow.up.backward.circle", animationType: .centering),
        MyItemModel(name: "Translation", imageName: "arrow.down.right", animationType: .translation),
        MyItemModel(name: "Rotation", imageName: "arrow.clockwise", animationType: .rotation),
        MyItemModel(name: "Scaling", imageName: "arrow.up.left.and.arrow.down.right", animationType: .scaling),
        MyItemModel(name: "Identity", imageName: "arrowshape.turn.up.backward", animationType: .identity),
        MyItemModel(name: "Repeating", imageName: "repeat", animationType: .repeating),
        MyItemModel(name: "Reversing", imageName: "arrow.left.arrow.right", animationType: .reversing),
        MyItemModel(name: "Sequence", imageName: "circle.grid.cross.right.fill", animationType: .sequence),
        MyItemModel(name: "Spring", imageName: "waveform.path.ecg", animationType: .spring),
        MyItemModel(name: "Controlled", imageName: "switch.2", animationType: .controlled),
        MyItemModel(name: "By a tap gesture", imageName: "hand.tap", animationType: .tapGesture),
        MyItemModel(name: "Moving", imageName: "hand.point.up.left", animationType: .moving),
        MyItemModel(name: "By a pan gesture", imageName: "hand.draw", animationType: .panGesture),
        MyItemModel(name: "Constraints", imageName: "rectangle.portrait.arrowtriangle.2.outward", animationType: .constraints)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Animations"
        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // autoscrolling to bottom
        if !firstAppearanceKey {
            firstAppearanceKey = true
            myCollectionView?.scrollsToBottom(animated: false)
        }
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
        
        let title = Menu.animationArray[indexPath.row].name
        let type = Menu.animationArray[indexPath.row].animationType
        let vc = MyAnimations(title: title, animationType: type)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Flow layout delegate
    
    // size for each item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: MyItemSizeConstants.side,
                      height: MyItemSizeConstants.side)
    }
}
