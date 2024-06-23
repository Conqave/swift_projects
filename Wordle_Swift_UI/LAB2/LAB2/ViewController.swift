//
//Created by Jan Dziewulski on 26/03/24
// ViewController.swift
//
import Cocoa
import AppKit

class ViewController: NSViewController {
    
    
    var textFieldColors: [NSTextField: NSColor] = [:]

    let model = Model()

    @IBOutlet weak var textField0: NSTextField!
    @IBOutlet weak var textField1: NSTextField!
    @IBOutlet weak var textField2: NSTextField!
    @IBOutlet weak var textField3: NSTextField!
    @IBOutlet weak var textField4: NSTextField!

    @IBOutlet weak var numberOfAttempts: NSTextFieldCell!
    
    var activeTextField: NSTextField?

    @IBAction func buttonCheck(_ sender: Any) {
        print(model.guessCount)
        let guess = textField0.stringValue + textField1.stringValue + textField2.stringValue + textField3.stringValue + textField4.stringValue
        numberOfAttempts.stringValue = String(model.guessCount)
        if guess.count == model.targetWord.count {
            let characterStates = model.checkCharacterPositions(guess: guess)
            updateTextFieldColors(characterStates: characterStates)

            if model.checkGuess(guess: guess) {
                showPopup(message: "Gratulacje! Odgadłeś słowo!")
                model.guessCount = 0
            } else {
                if model.guessCount >= 5 {
                    showPopup(message: "Niestety, nie udało Ci się odgadnąć słowa: \(guess)")
                    model.resetGame()
                } else {
                    showPopup(message: "Niepoprawne słowo. Spróbuj ponownie! \(guess)")
                    model.guessCount+=1
                    numberOfAttempts.stringValue = String(model.guessCount)
                }
            }
        }else{
            showPopup(message: "Hej! nie wypełniłeś wszystkich pól.")
        }
    }

    func setActiveTextField(_ textField: NSTextField) {
            resetTextFieldBackgrounds()
            activeTextField = textField
            activeTextField?.backgroundColor = NSColor.blue
        }
    
    
    @IBAction func button0(_ sender: Any) {
        setActiveTextField(textField0)
    }

    @IBAction func button1(_ sender: Any) {
        setActiveTextField(textField1)
    }

    @IBAction func button2(_ sender: Any) {
        setActiveTextField(textField2)
    }

    @IBAction func button3(_ sender: Any) {
        setActiveTextField(textField3)
    }

    @IBAction func button4(_ sender: Any) {
        setActiveTextField(textField4)
    }

    @IBAction func b0(_ sender: Any) {
        appendDigitToActiveTextField(digit: "0")
    }

    @IBAction func b1(_ sender: Any) {
        appendDigitToActiveTextField(digit: "1")
    }

    @IBAction func b2(_ sender: Any) {
        appendDigitToActiveTextField(digit: "2")
    }

    @IBAction func b3(_ sender: Any) {
        appendDigitToActiveTextField(digit: "3")
    }

    @IBAction func b4(_ sender: Any) {
        appendDigitToActiveTextField(digit: "4")
    }

    @IBAction func b5(_ sender: Any) {
        appendDigitToActiveTextField(digit: "5")
    }

    @IBAction func b6(_ sender: Any) {
        appendDigitToActiveTextField(digit: "6")
    }

    @IBAction func b7(_ sender: Any) {
        appendDigitToActiveTextField(digit: "7")
    }

    @IBAction func b8(_ sender: Any) {
        appendDigitToActiveTextField(digit: "8")
    }

    @IBAction func b9(_ sender: Any) {
        appendDigitToActiveTextField(digit: "9")
    }

    @IBAction func buttonNewGame(_ sender: Any) {
        model.resetGame()

        textField0.stringValue = ""
        textField1.stringValue = ""
        textField2.stringValue = ""
        textField3.stringValue = ""
        textField4.stringValue = ""
        resetTextFieldBackgrounds()
        activeTextField = nil
    }

    func appendDigitToActiveTextField(digit: String) {
        guard let activeTextField = activeTextField else { return }
        activeTextField.stringValue = digit
    }

    func updateTextFieldColors(characterStates: [CharacterState]) {
        let textFields = [textField0, textField1, textField2, textField3, textField4]
        for (index, state) in characterStates.enumerated() {
            switch state {
            case .correctPosition:
                textFields[index]?.backgroundColor = NSColor.green
            case .incorrectPosition:
                textFields[index]?.backgroundColor = NSColor.orange
            case .notInWord:
                textFields[index]?.backgroundColor = NSColor.white
            }
        }
    }

    func showPopup(message: String) {
        let alert = NSAlert()
        alert.messageText = message
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }

    func resetTextFieldBackgrounds() {
        textField0?.backgroundColor = NSColor.white
        textField1?.backgroundColor = NSColor.white
        textField2?.backgroundColor = NSColor.white
        textField3?.backgroundColor = NSColor.white
        textField4?.backgroundColor = NSColor.white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
    }
}
