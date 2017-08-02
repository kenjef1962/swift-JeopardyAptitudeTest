//
//  StartPresenter.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/29/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

protocol StartPresentation {
    var clueMethod: ClueMethod { get }
    var cluesPerRound: Int { get set }
    
    func randomizeMethod()
    func showQuestionView(clueMethod: ClueMethod)
    
    var refreshView:(() -> Void)? { get set }
}

final class StartPresenter: StartPresentation {
    var randomCount = 0
    var clueMethod = ClueMethod.random
    var cluesPerRound: Int {
        get { return interactor.cluesPerRound }
        set(value) { interactor.cluesPerRound = value }
    }
    
    var refreshView:(() -> Void)?
    
    fileprivate let coordinator: AppCoordination!
    fileprivate var interactor: AppInteraction!
    fileprivate var timer: Timer!
    
    init(coordinator: AppCoordination, interactor: AppInteraction) {
        self.coordinator = coordinator
        self.interactor = interactor
    }
    
    func randomizeMethod() {
        randomCount = 0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(StartPresenter.randomize)), userInfo: nil, repeats: true)
    }
    
    @objc func randomize() {
        randomCount += 1
        clueMethod = ClueMethod(rawValue: Int(arc4random_uniform(UInt32(ClueMethod.count))))!
        
        if randomCount == Constants.randomizations {
            timer.invalidate()
        }
        
        refreshView?()
    }
    
    func showQuestionView(clueMethod: ClueMethod) {
        coordinator.showQuestionView(clueMethod: clueMethod)
    }
}
