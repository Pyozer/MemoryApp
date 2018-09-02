//
//  Memory.swift
//  Memory
//
//  Created by i162431 on 22/01/2018.
//  Copyright © 2018 i162431. All rights reserved.
//

import Foundation

struct Memory {
    
    private var scoreHandler : ScoreHandler!
    
    private(set) var cards = [Card]()
    private(set) var flipCount = 0;
    private(set) var score: Int = 0
    /*private(set) var score: Int = 0 {
        didSet {
            score = (score < 0) ? 0 : score // Pas de score negatif
        }
    }*/
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Memory.init(at: \(index)): chosen index not in the cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        /* Mélange le tableau */
        cards.shuffle()
        
        scoreHandler = ScoreHandler()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Memory.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else if cards[index].isDiscovered {
                    score -= 1
                }
                cards[index].isFaceUp = true
                cards[index].isDiscovered = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
    
    public func isEndOfGame() -> Bool {
        for index in cards.indices {
            if !cards[index].isMatched {
                return false
            }
        }
        return true
    }
    
    public func saveScore(pseudo: String) -> Void {
        scoreHandler.addScore(score: Score(pseudo: pseudo, score: score, flips: flipCount, date: Date()))
        scoreHandler.saveAllScore()
    }
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            self.swapAt(firstUnshuffled, i)
        }
    }
}
