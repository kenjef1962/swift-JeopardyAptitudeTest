//
//  ResultsPresenter.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/29/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

protocol ResultsPresentation {
    var results: [(score: Int, clue: Clue)] { get }
    
    func getSummaryText() -> String
    func showStartView()
}

final class ResultsPresenter: ResultsPresentation {
    fileprivate var coordinator: AppCoordination!
    
    var results: [(score: Int, clue: Clue)]
    
    init(coordinator: AppCoordination, results: [(score: Int, clue: Clue)]) {
        self.coordinator = coordinator
        self.results = results
    }
    
    func getSummaryText() -> String {
        let countRight = results.filter { $0.score == 1 }.count
        
        return "So, you think that you were able to get the right answer for \(countRight) clues. You can check to see if your right by reviewing the real answers."
    }
    
    func showStartView() {
        coordinator.showStartView()
    }
}
