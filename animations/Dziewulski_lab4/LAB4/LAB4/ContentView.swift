//
//  ContentView.swift
//  LAB4
//
//  Created by Jan Dziewulski on 07/05/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("Czarna-dziura")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(.degrees(viewModel.rotationDegrees))
                    .edgesIgnoringSafeArea(.all)
                    .onAppear() {
                        viewModel.startAnimation()
                    }

                ForEach(viewModel.balls.indices, id: \.self) { index in
                    BallView(ball: viewModel.balls[index], maxHeight: geometry.size.height, maxWidth: geometry.size.width)
                }
            }
            .frame(width: 480, height: 480)
            .border(Color.pink, width: 5)
            .clipped()
        }
    }
}

