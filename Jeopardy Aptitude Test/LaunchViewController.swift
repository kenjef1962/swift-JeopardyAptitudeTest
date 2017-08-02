//
//  LaunchViewController.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/21/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit
import AVFoundation

class LaunchViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    fileprivate var presenter: LaunchPresentation!
    fileprivate var player: AVAudioPlayer!
    
    func configure(presenter: LaunchPresentation) {
        self.presenter = presenter
        self.player = self.initSound(resource: "JeopardyTheme")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))

        runAnimation()
        player.play()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        player.stop()
        presenter.showStartView()
    }
}

extension LaunchViewController {
    func runAnimation() {
        stackView.isHidden = false
        descLabel.isHidden = true
        startButton.isHidden = true
        
        let center = stackView.center
        stackView.center = view.center
        
        UIView.animate(
            withDuration: 1.0,
            delay: 0.5,
            options: [],
            animations: {
                self.stackView.center = center
            },
            completion: { _ in
                self.descLabel.isHidden = false
                self.startButton.isHidden = false
                
            })
        
    }
}
