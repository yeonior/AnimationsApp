//
//  MyItemModel.swift
//  MyAnimations
//
//  Created by ruslan on 20.09.2021.
//

import Foundation

enum AnimationType {
    case appearing
    case coloring
    case centering
    case translation
    case rotation
    case scaling
    case identity
    case repeating
    case reversing
    case sequence
    case spring
    case controlled
    case tapGesture
}

struct MyItemModel {
    var name: String
    var imageName: String
    var animationType: AnimationType
}
