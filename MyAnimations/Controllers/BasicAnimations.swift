//
//  BasicAnimations.swift
//  MyAnimations
//
//  Created by ruslan on 21.09.2021.
//

import UIKit

final class BasicAnimations: UIViewController {
    
    private var animationType: AnimationType? = nil
    
    private let square: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        label.backgroundColor = .red
        label.clipsToBounds = true
        label.layer.cornerRadius = 16
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureAnimation(with: animationType)
    }
    
    // MARK: - Init
    init(animationType: AnimationType) {
        super.init(nibName: nil, bundle: nil)
        self.animationType = animationType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Animation configuring
    private func configureAnimation(with type: AnimationType?) {
        guard let animationType = type else { return }
        
        view.addSubview(square)
        
        switch animationType {
        case .movement:
            UIView.animate(withDuration: 2.0) {
                self.square.center = self.view.center
            }
        }
    }
}
