//
//  ResultsViewCell.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/29/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit

class ResultsViewCell: UITableViewCell {
    @IBOutlet weak var thumbDownLabel: UILabel!
    @IBOutlet weak var thumbUpLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    func configure(result: (score: Int, clue: Clue)) {
        thumbDownLabel.text = result.score == -1 ? "👎" : ""
        thumbUpLabel.text = result.score == 1 ? "👍" : ""
        
        let clue = result.clue
        categoryLabel.text = clue.category
        roundLabel.text = "\(clue.round) (\(clue.value))"
        clueLabel.text = clue.question
        answerLabel.text = clue.answer
    }
    
    static let identifier = "resultsViewCell"
}
