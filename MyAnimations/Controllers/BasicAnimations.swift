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
        label.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 50, y: UIScreen.main.bounds.height / 2 - 50, width: 100, height: 100)
        label.backgroundColor = .red
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureAnimation(with: animationType)
    }
    
    // MARK: - Init
    init(title: String, animationType: AnimationType) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.animationType = animationType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Animation configuring
    private func configureAnimation(with type: AnimationType?) {
        guard let animationType = type else { return }
        
        view.addSubview(square)
        
        // choosing animation
        switch animationType {
        case .movement:
            square.frame.origin.x = 10
            square.frame.origin.y = 100
            UIView.animate(withDuration: 2.0) {
                self.square.center = self.view.center
            }
        case .appearing:
            self.square.alpha = 0.0
            UIView.animate(withDuration: 2.0) {
                self.square.alpha = 1.0
            }
        case .rotation:
            UIView.animate(withDuration: 2.0) {
                self.square.transform = CGAffineTransform(rotationAngle: .pi)
            }
        case .scale:
            UIView.animate(withDuration: 2.0) {
                self.square.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
        }
    }
}
