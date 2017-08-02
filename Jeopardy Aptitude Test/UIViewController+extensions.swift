//
//  UIViewController+extensions.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/31/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension UIViewController {
    func initSound(resource: String) -> AVAudioPlayer {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "mp3") else { fatalError() }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            return try AVAudioPlayer(contentsOf: url)
        }
        catch {
            fatalError()
        }
    }
}

