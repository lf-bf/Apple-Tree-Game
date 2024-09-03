//
//  Game.swift
//  ApplePie_2
//
//  Created by Luiz Fernando Brasão on 26/08/24.
//

import Foundation



struct Game{
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed(letter: Character) -> Int{
        guessedLetters.append(letter)
        if word.contains(letter){
            return +1
        }else{
            incorrectMovesRemaining -= 1
            return -1
        }
    }
    
    var formattedWord: String{
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
            }else{
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
}
