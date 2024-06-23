//
//Created by Jan Dziewulski on 26/03/24
// Model.swift
//
import Foundation

enum CharacterState {
    case correctPosition
    case incorrectPosition
    case notInWord
}

class Model {
    var targetWord: String = "01234"
    var guessCount: Int = 0

    func checkGuess(guess: String) -> Bool {
        return guess == targetWord
    }

    func resetGame() {
        var randomDigits: [Character] = []
        for _ in 0..<5 {
            let randomNumber = Int.random(in: 0...9)
            let randomDigit = String(randomNumber)
            randomDigits.append(Character(randomDigit))
        }
        targetWord = String(randomDigits)

        guessCount = 0
        print("--------------------------------------------")
        print("Słowo docelowe w ramach testu wypisane: \(targetWord)")
        print("--------------------------------------------")
    }

    func checkCharacterPositions(guess: String) -> [CharacterState] {
        var characterStates: [CharacterState] = []

        for (index, guessChar) in guess.enumerated() {
            if let targetIndex = targetWord.firstIndex(of: guessChar) {
                if targetWord.distance(from: targetWord.startIndex, to: targetIndex) == index {
                    characterStates.append(.correctPosition)
                } else {
                    characterStates.append(.incorrectPosition)
                }
            } else {

                characterStates.append(.notInWord)
            }
        }
        return characterStates
    }
}
