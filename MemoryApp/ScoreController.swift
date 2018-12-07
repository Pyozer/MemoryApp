//
//  ScoreController.swift
//  Memory
//
//  Created by i162431 on 29/03/2018.
//  Copyright © 2018 i162431. All rights reserved.
//

import Foundation
import UIKit

class ScoreController : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private var scoresHandler: ScoreHandler!
    private var indexSelectedScoreCell: Int?
    
    override func viewDidLoad() {
        scoresHandler = ScoreHandler()
    }

    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoresHandler.getAllSavedScore().count
    }
    
    // cell height
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ScoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellScore", for: indexPath) as! ScoreTableViewCell
        
        let score: Score = scoresHandler.getAllSavedScore()[indexPath.row]
        
        cell.rang.text = "#" + String(indexPath.row + 1)
        cell.pseudo.text = score.pseudo
        cell.score.text = String(score.score)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelectedScoreCell = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ScoreInfo" && indexSelectedScoreCell != nil) {
            let destinationVC: ScoreInfoController = segue.destination as! ScoreInfoController
            destinationVC.indexScore = indexSelectedScoreCell
        }
    }
    
}
