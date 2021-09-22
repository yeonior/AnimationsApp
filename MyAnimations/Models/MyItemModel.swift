//
//  MyItemModel.swift
//  MyAnimations
//
//  Created by ruslan on 20.09.2021.
//

import Foundation

enum AnimationType {
    case centering
    case appearing
    case rotation
    case scaling
    case translation
}

struct MyItemModel {
    var name: String
    var imageName: String
    var animationType: AnimationType
}
