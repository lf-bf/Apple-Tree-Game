//
//  ViewController.swift
//  ApplePie
//
//  Created by Luiz Fernando Brasão on 19/08/24.
//

import UIKit

var listOfWorlds = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]

let incorrectMovesAllowed = 7

class ViewController: UIViewController {
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var totalpoints: UILabel!
    @IBOutlet var scoreChangeLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreChangeLabel.isHidden = true
        newRound()
    }
    
    var currentGame: Game!
    var totalWins = 0{
        didSet{
            newRound()
        }
    }
    var totalLosses = 0{
        didSet{
            newRound()
        }
    }
    
    var totalScorePoints = 10
    
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    
    func animationLabel(){
        scoreChangeLabel.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseInOut, animations: {
                self.scoreChangeLabel.alpha = 0 // Fade out the label after 2 seconds
            }) { _ in
                self.scoreChangeLabel.isHidden = true // Hide the label after the fade-out
                self.scoreChangeLabel.alpha = 1 // Reset the alpha for next time
            }
    }
    
    
    func newRound(){
        if !listOfWorlds.isEmpty{
            let newWord = listOfWorlds.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [] )
            enableLetterButtons(true)
            updateUI()
        }else{
            enableLetterButtons(false)
        }
    }
    
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        totalpoints.text = "Total Points: \(totalScorePoints)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
            totalScorePoints -= 5
            scoreChangeLabel.text = "-5"
            updateUI()
        }else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
            totalScorePoints += 5
            scoreChangeLabel.text = "+5"
            updateUI()
        }else{
            updateUI()
        }
    }
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        let scoreChange = currentGame.playerGuessed(letter: letter)
        totalScorePoints += scoreChange
        if scoreChange > 0 {
                scoreChangeLabel.text = "+\(scoreChange)"
            } else {
                scoreChangeLabel.text = "\(scoreChange)"
            }
        animationLabel()
        updateGameState()
    }
    

}

