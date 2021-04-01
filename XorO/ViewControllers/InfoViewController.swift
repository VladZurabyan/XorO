//
//  InfoViewController.swift
//  XorO
//
//  Created by Haykanush on 12/19/19.
//  Copyright © 2019 Armen Shahvaladyan. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    let text = "Tic-tac-toe is a simple, two-player game that, if played optimally by both players, will always result in a tie. The game is also called noughts and crosses or Xs and Os. Tic-tac-toe is a game that is traditionally played by being drawn on paper, and it can be played on a computer or on a variety of media.\n \n History of Tic-Tac-Toe An early variation of the game was played in the Roman Empire, around the 1st century B.C.It was called 'terni lapilli,'which means 'three pebbles at a time.'The game's grid markings have been found chalked all over Roman ruins.Evidence of the game was also found in ancient Egyptian ruins.\n \nThe first print reference to 'noughts and crosses,'the British name for the game, appeared in 1864.The first print reference to a game called 'tick-tack-toe' occurred in 1884 but referred to a children's game played on a slate.\n \n Gameplay The goal of tic-tac-toe is to be the first player to get three in a row on a 3-by-3 grid.To start, one player draws a board, creating a grid of squares, usually 3-by-3.\n \n In a 3-by-3 grid game, the player who is playing 'X' always goes first. Players alternate placing Xs and Os on the board until either player has three in a row, horizontally, vertically, or diagonally or until all squares on the grid are filled. If a player is able to draw three Xs or three Os in a row, then that player wins. If all squares are filled and neither player has made a complete row of Xs or Os, then the game is a draw.\n \n One of the game's best strategies involves creating a 'fork,' which is placing your mark in such a way that you have the opportunity to win two ways on your next turn. Your opponent can only block one, thereby, you can win after that."
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       let range1 = (text as NSString).range(of: "Tic-tac-toe")
              let range2 = (text as NSString).range(of: "History of Tic-Tac-Toe")
              let range3 = (text as NSString).range(of: "The first print reference")
              let range4 = (text as NSString).range(of: "Gameplay The goal")
              let range5 = (text as NSString).range(of: "In a 3-by-3 grid game")
              let range6 = (text as NSString).range(of: "One of the game's best strategies")
        
        //let range7 = (text as NSString).range(of: "is a simple, two-player game that, if played optimally by both players, will always result in a tie. The game is also called noughts and crosses or Xs and Os. Tic-tac-toe is a game that is traditionally played by being drawn on paper, and it can be played on a computer or on a variety of media.\n \n An early variation of the game was played in the Roman Empire, around the 1st century B.C.It was called 'terni lapilli,'which means 'three pebbles at a time.'The game's grid markings have been found chalked all over Roman ruins.Evidence of the game was also found in ancient Egyptian ruins.\n \n to 'noughts and crosses,'the British name for the game, appeared in 1864.The first print reference to a game called 'tick-tack-toe' occurred in 1884 but referred to a children's game played on a slate.\n \n  of tic-tac-toe is to be the first player to get three in a row on a 3-by-3 grid.To start, one player draws a board, creating a grid of squares, usually 3-by-3.\n \n, the player who is playing 'X' always goes first. Players alternate placing Xs and Os on the board until either player has three in a row, horizontally, vertically, or diagonally or until all squares on the grid are filled. If a player is able to draw three Xs or three Os in a row, then that player wins. If all squares are filled and neither player has made a complete row of Xs or Os, then the game is a draw.\n \n involves creating a 'fork,' which is placing your mark in such a way that you have the opportunity to win two ways on your next turn. Your opponent can only block one, thereby, you can win after that.")
        
        let attributString = NSMutableAttributedString(string: text)

        let attributes1: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.blue, .font: UIFont.italicSystemFont(ofSize: 35) ]
        
        let attributes2: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.blue, .font: UIFont.italicSystemFont(ofSize: 35) ]
        
        let attributes3: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.blue, .font: UIFont.italicSystemFont(ofSize: 35) ]
        
        let attributes4: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.blue, .font: UIFont.italicSystemFont(ofSize: 35) ]
        
        let attributes5: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.blue, .font: UIFont.italicSystemFont(ofSize: 35) ]
        
         let attributes6: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.blue, .font: UIFont.italicSystemFont(ofSize: 35) ]
        
        //let attributes7: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.orange, .font: UIFont.boldSystemFont(ofSize: 30) ]
        
        
        attributString.addAttributes(attributes1, range: range1)
        attributString.addAttributes(attributes2, range: range2)
        attributString.addAttributes(attributes3, range: range3)
        attributString.addAttributes(attributes4, range: range4)
        attributString.addAttributes(attributes5, range: range5)
        attributString.addAttributes(attributes6, range: range6)
        
       // attributString.addAttributes(attributes7, range: range7)
        textView.attributedText = attributString
        
        
    }
    

}
