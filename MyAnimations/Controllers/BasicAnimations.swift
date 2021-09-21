//
//  BasicAnimations.swift
//  MyAnimations
//
//  Created by ruslan on 21.09.2021.
//

import UIKit

final class BasicAnimations: UIViewController {
    
    private var animationType: AnimationType? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
    }
    
    init(animationType: AnimationType) {
        super.init(nibName: nil, bundle: nil)
        self.animationType = animationType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
