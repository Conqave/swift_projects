//
//  ViewModel.swift
//  lab3
//
//  Created by Jan Dziewulski on 16/04/2024.
//
import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var word = Model(text: "12345", guessed: false, maxAttemps: 5)
    @Published var attempts = Array(repeating: Array(repeating: "", count: 5), count: 5)
    @Published var activeField: Int? = nil
    @Published var colors = Array(repeating: Array(repeating: Color.black, count: 5), count: 5)
    @Published var alertItem: AlertItem?
    @Published var currentAttempt = 0
    
    let maxAttempts = 5
    
    init() {
        resetGame()
    }
    
    func guess() {
        if currentAttempt >= maxAttempts {
            alertItem = AlertItem(
                title: "Przegrałeś",
                message: "Poprawne hasło to: \(word.text)",
                dismissButton: .default(Text("OK"), action: {
                    self.resetGame()
                })
            )
            return
        }
        
        if word.text == attempts[currentAttempt].joined() {
            word.guessed = true
            alertItem = AlertItem(title: "Zgadłeś hasło", message: "Twoje hasło to: \(word.text)", dismissButton: .default(Text("OK"), action: {
                self.resetGame()
            }))
        }
        for (index, char) in attempts[currentAttempt].enumerated() {
            //jeśli pusty to oznaczenie czerwone, czyli użytkownik nie wprowadził danej
            if char.isEmpty {
                colors[currentAttempt][index] = Color.red
            } else if !word.text.contains(char) {
                //jeśli znak nie wystąpił to niebieskie
                colors[currentAttempt][index] = Color.blue
            } else if word.text.contains(char) {
                //jeśli znak wystąpił to pomarańczowe
                colors[currentAttempt][index] = Color.orange
            }
            //jeśli na poprawnym miejscu, to zielone
            if !char.isEmpty, word.text.count > index, word.text[word.text.index(word.text.startIndex, offsetBy: index)] == Character(char) {
                colors[currentAttempt][index] = Color.green
            }
        }
        currentAttempt += 1
        activeField = 0
    }
    
    func input(number: Int) {
        if let activeField = activeField, currentAttempt < maxAttempts {
            attempts[currentAttempt][activeField] = number == 0 ? "0" : "\(number)"
            // Przejście do następnego pola
            if activeField < 4 {
                self.activeField = activeField + 1
            }
        }
    }
    
    func resetGame() {
        let randomNumber = Int.random(in: 0...99999)
        let newWord = String(format: "%05d", randomNumber)
        print("New word: \(newWord)")
        word = Model(text: newWord, guessed: false, maxAttemps: 5)
        attempts = Array(repeating: Array(repeating: "", count: 5), count: 5)
        colors = Array(repeating: Array(repeating: Color.black, count: 5), count: 5)
        currentAttempt = 0
        activeField = 0
    }
}
