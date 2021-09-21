//
//  MyItemModel.swift
//  MyAnimations
//
//  Created by ruslan on 20.09.2021.
//

import Foundation

enum AnimationType {
    case movement
}

struct MyItemModel {
    var name: String
    var imageName: String
    var animationType: AnimationType
}
