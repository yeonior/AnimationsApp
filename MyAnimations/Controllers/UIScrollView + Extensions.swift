//
//  UIScrollView + Extensions.swift
//  MyAnimations
//
//  Created by ruslan on 24.09.2021.
//

import UIKit

extension UIScrollView {
    
    // scrolling to bottom
    func scrollsToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: -MyItemSizeConstants.spacing, y: contentSize.height - bounds.height + safeAreaInsets.bottom + MyItemSizeConstants.spacing)
        setContentOffset(bottomOffset, animated: animated)
    }
}
