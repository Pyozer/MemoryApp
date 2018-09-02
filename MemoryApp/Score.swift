//
//  Score.swift
//  Memory
//
//  Created by i162431 on 21/03/2018.
//  Copyright © 2018 i162431. All rights reserved.
//

import Foundation

class Score : NSObject, NSCoding {
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("scores")
    
    let pseudo : String
    let score : Int
    let flips : Int
    let date : Date
    
    init(pseudo: String, score: Int, flips: Int, date: Date) {
        self.pseudo = pseudo
        self.score = score
        self.flips = flips
        self.date = date
    }

    required convenience init?(coder decoder: NSCoder) {
        let pseudo = decoder.decodeObject(forKey: ScoreKey.pseudo) as? String ?? ""
        let score = decoder.decodeInteger(forKey: ScoreKey.score)
        let flips = decoder.decodeInteger(forKey: ScoreKey.flips)
        let date = decoder.decodeObject(forKey: ScoreKey.date) as? Date ?? Date()
        
        self.init(pseudo: pseudo, score: score, flips: flips, date: date)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(pseudo, forKey: ScoreKey.pseudo)
        coder.encode(score, forKey: ScoreKey.score)
        coder.encode(flips, forKey: ScoreKey.flips)
        coder.encode(date, forKey: ScoreKey.date)
    }
    
    func getDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy à HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}

struct ScoreKey {
    static let pseudo = "pseudo"
    static let score = "score"
    static let flips = "flips"
    static let date = "date"
}
