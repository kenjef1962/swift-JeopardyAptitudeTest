//
//  ClueViewController.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/21/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit
import AVFoundation

class ClueViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var showNumberLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var clueStackView: UIStackView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var clueNumberLabel: UILabel!
    
    fileprivate var presenter: CluePresentation!
    
    fileprivate var timer: Timer!
    fileprivate var timerValue = 0
    fileprivate var player: AVAudioPlayer!
    
    func configure(presenter: CluePresentation) {
        self.presenter = presenter
        self.presenter.refreshView = { self.refreshView() }
        self.player = initSound(resource: "JeopardyTimesUp")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        refreshView()
    }
    
    @IBAction func thumbsButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        presenter.updateScore(score: sender.tag)
    }
}

extension ClueViewController {
    func refreshView() {
        title = "Clue \(presenter.clueNo + 1) of \(presenter.clueCount)"
        
        let clue = presenter.clue
        categoryLabel.text = clue.category
        roundLabel.text = clue.round
        showNumberLabel.text = "\(clue.showNumber) (\(clue.airDate))"
        valueLabel.text = clue.value
        clueNumberLabel.text = "\(presenter.clueNo + 1) of \(presenter.cluesPerRound)"
        
        clueStackView.isHidden = true
        clueLabel.text = ""
        timerLabel.text = ""
        timerValue = Constants.clueTimerTicks
        
        buttonStackView.isHidden = true
        
        timer = Timer.scheduledTimer(timeInterval: Constants.categoryTimer, target: self, selector: (#selector(ClueViewController.showClue)), userInfo: nil, repeats: false)
    }
    
    @objc func showClue() {
        timer.invalidate()
        
        clueStackView.isHidden = false
        clueLabel.text = presenter.clue.question
        timerLabel.text = String(format: "0:%02d", timerValue)
        timerLabel.textColor = .black
        
        buttonStackView.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: Constants.clueTimer, target: self, selector: (#selector(ClueViewController.timerTick)), userInfo: nil, repeats: true)
    }
    
    @objc func timerTick() {
        timerValue -= 1
        timerLabel.text = String(format: "0:%02d", timerValue)
        
        if timerValue == 0 {
            player.play()
            timer.invalidate()
            presenter.updateScore(score: 0)
            return
        }
        
        timerLabel.textColor = timerValue <= 5 ? .red : .black
    }
}
