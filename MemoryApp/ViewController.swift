//
//  ViewController.swift
//  MemoryApp
//
//  Created by i162431 on 22/01/2018.
//  Copyright © 2018 i162431. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var game: Memory!
    private(set) var themeManager: ThemeManager!
    
    private var numberOfPairsOfCards: Int {
        return (cardsButton.count + 1) / 2
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var newGameBtn: UIButton!
    @IBOutlet private weak var themeName: UILabel!
    @IBOutlet private var cardsButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGame()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardsButton.index(of: sender) {
            game.chooseCard(at: cardNumber);
            updateViewFromModel();
        }
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        initGame()
    }
    
    private func initGame() {
        game = Memory(numberOfPairsOfCards: numberOfPairsOfCards)
        themeManager = ThemeManager(rand: true)
        updateViewFromModel()
        updateLabel(label: themeName, text: themeManager.getTheme().name)
        newGameBtn.backgroundColor = themeManager.getTheme().color
    }
    
    private func updateFlipLabel() {
        updateLabel(label: flipCountLabel, text: "Flip" + ((game.flipCount > 1) ? "s" : "") + ": \(game.flipCount)")
    }
    
    private func updateScoreLabel() {
        updateLabel(label: scoreLabel, text: "Score: \(game.score)")
    }
    
    private func updateLabel(label: UILabel, text: String) {
        label.attributedText = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key(rawValue: ".strokeWidth"): 5,
                NSAttributedString.Key(rawValue: ".strokeColor"): #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            ]
        )
    }
    
    private func updateViewFromModel() {
        for index in cardsButton.indices {
            let button = cardsButton[index];
            let card = game.cards[index];
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : themeManager.getTheme().color
            }
        }
        updateFlipLabel()
        updateScoreLabel()
        
        if(game.isEndOfGame()) {
            showEndDialog()
        }
    }
    
    private var emoji = [Int: String]()
    
    private func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil, themeManager.getTheme().getNbEmojies() > 0 {
            let indexRandEmojie = themeManager.getTheme().getNbEmojies().arc4random
            emoji[card.identifier] = themeManager.getTheme().removeEmojie(index: indexRandEmojie);
        }
        return emoji[card.identifier] ?? "?"
    }

    private func showEndDialog() -> Void {
        // create the alert
        let alert = UIAlertController(
            title: "End of game",
            message: "You finish the game !\nYour score is " + String(game.score),
            preferredStyle: UIAlertController.Style.alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Pseudo"
        }
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "New game", style: .default, handler: { [weak alert] (_) in
            let textFieldPseudo = alert?.textFields![0] // Force unwrapping because we know it exists.
            if !(textFieldPseudo?.text?.isEmpty)! {
                self.game.saveScore(pseudo: (textFieldPseudo?.text)!)
            }
            self.initGame()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
            let textFieldPseudo = alert?.textFields![0] // Force unwrapping because we know it exists.
            if !(textFieldPseudo?.text?.isEmpty)! {
                self.game.saveScore(pseudo: (textFieldPseudo?.text)!)
            }
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        return 0
    }
}

