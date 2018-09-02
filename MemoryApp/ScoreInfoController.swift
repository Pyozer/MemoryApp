//
//  ScoreInfoController.swift
//  MemoryApp
//
//  Created by Jean-Charles Moussé on 31/03/2018.
//  Copyright © 2018 i162431. All rights reserved.
//

import Foundation
import UIKit

class ScoreInfoController: UIViewController {
    
    var indexScore : Int?
    
    @IBOutlet weak var labelRang: UILabel!
    @IBOutlet weak var labelPseudo: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelFlips: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(indexScore == nil) {
            indexScore = 0
        }
        let score = ScoreHandler().getAllSavedScore()[indexScore!]
        
        labelRang.text = "RANK  #" + String(describing: indexScore! + 1)
        labelPseudo.text = score.pseudo
        labelScore.text = String(describing: score.score)
        labelFlips.text = String(describing: score.flips)
        labelDate.text = score.getDateFormatted()
    }
    
}
