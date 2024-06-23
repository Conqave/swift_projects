//
//  BallView.swift
//  LAB4
//
//  Created by Jan Dziewulski on 07/05/2024.
//

import SwiftUI

struct BallView: View {
    @ObservedObject var ball: Ball
    let maxHeight: CGFloat
    let maxWidth: CGFloat
    let ballBorderOffset: CGFloat = 100
    let animationDuration: Double = 2
    let selfRotationAnimationDuration: Double = 1
    let rotationAngle: Double = 45
    let selfRotationAngle: Double = 90

    var body: some View {
        Image(ball.ballImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .scaleEffect(ball.isReady ? ball.ballScale : 1)
            .frame(width: ball.ballSize, height: ball.ballSize)
            .offset(ball.ballOffset)
            .rotationEffect(.degrees(ball.rotation))
            .rotationEffect(.degrees(ball.selfRotation), anchor: .center)
            .animation(ball.startAnimation ? Animation.easeIn(duration: animationDuration).repeatForever(autoreverses: false) : nil, value: ball.ballOffset)
            .animation(ball.startAnimation ? Animation.easeIn(duration: animationDuration).repeatForever(autoreverses: false) : nil, value: ball.ballScale)
            .animation(ball.startAnimation ? Animation.linear(duration: animationDuration).repeatForever(autoreverses: false) : nil, value: ball.rotation)
            .animation(ball.startAnimation ? Animation.linear(duration: selfRotationAnimationDuration).repeatForever(autoreverses: false) : nil, value: ball.selfRotation)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1...3)) {
                    ball.startAnimation = true
                    ball.isReady = true
                    ball.ballOffset = CGSize(width: 0, height: 0)
                    ball.ballScale = 0.0
                    ball.rotation = rotationAngle
                    ball.selfRotation = selfRotationAngle
                }
            }
    }
}

