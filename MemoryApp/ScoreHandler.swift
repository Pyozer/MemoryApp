//
//  ScoreHandler.swift
//  Memory
//
//  Created by i162431 on 29/03/2018.
//  Copyright © 2018 i162431. All rights reserved.
//

import Foundation

class ScoreHandler {
    
    private var scores: [Score]!
    
    init() {
        loadScores()
    }
    
    private func loadScores() -> Void {
        scores = NSKeyedUnarchiver.unarchiveObject(withFile: Score.ArchiveURL.path) as? [Score] ?? []
        sortScores()
    }
    
    private func sortScores() -> Void {
        scores = scores.sorted(by: { $0.score > $1.score || ($0.score > $1.score && $0.flips < $1.flips) })
    }
    
    func getAllSavedScore() -> [Score] {
        return scores;
    }
    
    func saveAllScore() -> Void {
        NSKeyedArchiver.archiveRootObject(scores, toFile: Score.ArchiveURL.path)
    }
    
    func addScore(score: Score) -> Void {
        scores.append(score)
        sortScores()
    }
    
}

struct ScoreHandlerKey {
    static let scores = "scores"
}
