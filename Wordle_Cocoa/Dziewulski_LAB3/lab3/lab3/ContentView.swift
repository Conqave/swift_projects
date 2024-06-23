//
//  ViewModel.swift
//  lab3
//
//  Created by Jan Dziewulski on 16/04/2024.
//


import SwiftUI



struct AlertItem: Identifiable {
    var id = UUID()
    var title: String
    var message: String
    var dismissButton: Alert.Button
}

struct ContentView: View {
    
    
    
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            //Pola
            ForEach(0..<viewModel.attempts.count, id: \.self) { attempt in
                HStack {
                    ForEach(0..<5) { index in
                        Text(viewModel.attempts[attempt][index])
                            .frame(width: 50, height: 50)
                            .background(viewModel.colors[attempt][index])
                            .foregroundColor(.white)
                            .font(.system(size: 32))
                            .multilineTextAlignment(.center)
                            // Jeśli pole jest aktywne, kolor obramowania zmieni się na czerwony. W przeciwnym razie, kolor pozostanie szary. Oznaczenie statusu pola, do którego są wpisywane dane.
                            .border(viewModel.activeField == index && attempt == viewModel.currentAttempt ? Color.pink : Color.gray, width: (viewModel.activeField == index && attempt == viewModel.currentAttempt) ? 4 : 1)
                    }
                }
            }
            //Strzałki wskazujące
            HStack {
                ForEach(0..<5) { index in
                    Button(action: {
                        viewModel.activeField = index
                    }) {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)


                    }
                    .frame(width: 50, height: 50)
                    
                }
            }
            //Klawiatura ekranowa
            HStack {
                ForEach(0..<10) { number in
                    Button(action: {
                        viewModel.input(number: number)
                    }) {
                        Text("\(number)")
                    }
                    .frame(width: 30, height: 30)
                }
            }
            Button(action: {
                viewModel.guess()
            }) {
                Text("Guess")
            }
            .padding()
            Button(action: {
                viewModel.resetGame()
            }) {
                Text("Reset Game")
            }
            .padding()
        }.padding(10)
        .alert(item: $viewModel.alertItem) { item in
            Alert(title: Text(item.title), message: Text(item.message), dismissButton: item.dismissButton)
        }
    }
}
