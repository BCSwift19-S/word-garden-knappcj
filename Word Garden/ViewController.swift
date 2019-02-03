//
//  ViewController.swift
//  Word Garden
//
//  Created by Christopher Knapp on 1/31/19.
//  Copyright © 2019 Christopher Knapp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var lettersGuessed = ""
    var wordToGuess = "SWIFT"
    var maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    func updateUIAfterGuess(){
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    func formatUserGuessLabel(){
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
        
    }
    func guessALetter(){
        formatUserGuessLabel()
        guessCount += 1
        let currentLetterGuessed = guessedLetterField.text
        if !wordToGuess.contains(guessedLetterField.text!) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower" + "\(wrongGuessesRemaining)")
        }
        let revealedWord = userGuessLabel.text!
        if wrongGuessesRemaining == 0 {
           playAgainButton.isHidden = false
            guessLetterButton.isEnabled = false
            guessedLetterField.isEnabled = false
            guessCountLabel.text = "So Sorry, you are out of guesses. Try Again?"
        } else if !revealedWord.contains("_") {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! It took you \(guessCount) guesses to guess the word!"
        } else {
            let guess = (guessCount == 1 ? "guess" : "guesses")
            
            guessCountLabel.text = "You've made \(guessCount) \(guess)"
        }
    }
    @IBAction func guessedLetterFieldChanged(_ sender: UIButton) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = String(letterGuessed)
            guessLetterButton.isEnabled = true
        } else {
            guessLetterButton.isEnabled = false
            
        }
    }

    @IBAction func doneKeyPressed(_ sender: UITextField) {
        print("in doneKeyPressed, is guessedLetterField the first responder?", guessedLetterField.isFirstResponder)
        guessALetter()
        updateUIAfterGuess()
        
    }
    
    @IBAction func guessButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
        
        
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessLetterButton.isEnabled = true
        guessedLetterField.isEnabled = true
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        flowerImageView.image = UIImage(named: "flower8")
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've made 0 guesses"
        guessCount = 0
    }
    
}

