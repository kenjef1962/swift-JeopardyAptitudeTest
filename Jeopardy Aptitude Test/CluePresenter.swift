//
//  CluePresenter.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/29/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

protocol CluePresentation {
    var clueNo: Int { get }
    var cluesPerRound: Int { get }
    var clueCount: Int { get }
    var clue: Clue { get }
    
    func updateScore(score: Int)
    
    var refreshView:(() -> Void)? { get set }
}

final class CluePresenter: CluePresentation {
    fileprivate let coordinator: AppCoordination!
    fileprivate let interactor: AppInteraction!
    
    var clues: [Clue]!
    
    var clueNo = 0
    var cluesPerRound: Int { return interactor.cluesPerRound }
    var clueCount: Int {  return clues.count }
    var clue: Clue { return clues[clueNo] }
    
    var results: [(score: Int, clue: Clue)] = []
    
    var refreshView:(() -> Void)?
    
    init(coordinator: AppCoordination, interactor: AppInteraction, clueMethod: ClueMethod) {
        self.coordinator = coordinator
        self.interactor = interactor
        
        self.clues = interactor.getClues(count: interactor.cluesPerRound, clueMethod: clueMethod)
    }
    
    func updateScore(score: Int) {
        results.append((score: score, clue: clues[clueNo]))
        
        clueNo += 1
        
        guard clueNo < clueCount else {
            coordinator.showResultsView(results: results)
            return
        }
        
        refreshView?()
    }
}
