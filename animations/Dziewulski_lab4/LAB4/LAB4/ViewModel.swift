//
//  ViewModel.swift
//  LAB4
//
//  Created by Jan Dziewulski on 07/05/2024.
//

import SwiftUI
import Foundation

class ViewModel: ObservableObject {
    @Published var rotationDegrees = 0.0
    @Published var balls = [Ball]()

    init() {
        for _ in 0..<20 {
            let ballSize = CGFloat.random(in: 50...200)
            let radius = sqrt(pow(480, 2) + pow(480, 2)) / 2 + 25
            let angle = CGFloat.random(in: 0..<2 * .pi)
            var ballOffset: CGSize

            switch Int.random(in: 0..<4) {
            case 0:
                ballOffset = CGSize(width: radius * CGFloat(cos(Double(angle))), height: -radius * CGFloat(sin(Double(angle))))
            case 1:
                ballOffset = CGSize(width: radius * CGFloat(cos(Double(angle))), height: radius * CGFloat(sin(Double(angle))))
            case 2:
                ballOffset = CGSize(width: -radius * CGFloat(cos(Double(angle))), height: radius * CGFloat(sin(Double(angle))))
            default:
                ballOffset = CGSize(width: -radius * CGFloat(cos(Double(angle))), height: -radius * CGFloat(sin(Double(angle))))
            }
            let ballImage = ["Baseball", "Basketball", "Billardball", "Football", "Tennisball", "Golfball", "Volleyball"].randomElement() ?? "Baseball"
            balls.append(Ball(maxHeight: 480, maxWidth: 480, ballSize: ballSize, ballOffset: ballOffset, ballImage: ballImage))
        }
    }

    func startAnimation() {
        withAnimation(Animation.linear(duration: 20).repeatForever(autoreverses: false)) {
            rotationDegrees = 180
        }
        for index in balls.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) + Double.random(in: 1...3)) {
                self.balls[index].startAnimation = true
                self.balls[index].isReady = true
                self.balls[index].ballOffset = CGSize(width: 0, height: 0)
                self.balls[index].ballScale = 0.0
                self.balls[index].rotation = 45
                self.balls[index].selfRotation = 90
            }
        }
    }
}
