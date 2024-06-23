//
//  Ball.swift
//  LAB4
//
//  Created by Jan Dziewulski on 07/05/2024.
//

import SwiftUI

class Ball: ObservableObject {
    let maxHeight: CGFloat
    let maxWidth: CGFloat
    @Published var ballSize: CGFloat
    @Published var ballOffset: CGSize
    let ballImage: String
    @Published var ballScale: CGFloat = 1.0
    @Published var isReady = false
    @Published var startAnimation = false
    @Published var rotation: Double = 0
    @Published var selfRotation: Double = 0

    init(maxHeight: CGFloat, maxWidth: CGFloat, ballSize: CGFloat, ballOffset: CGSize, ballImage: String) {
        self.maxHeight = maxHeight
        self.maxWidth = maxWidth
        self.ballSize = ballSize
        self.ballOffset = ballOffset
        self.ballImage = ballImage
    }
}


