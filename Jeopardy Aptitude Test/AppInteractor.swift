//
//  AppInteractor.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/21/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

protocol AppInteraction {
    var cluesPerRound: Int { get set }
    func getClues(count: Int, clueMethod: ClueMethod) -> [Clue]
}

class AppInteractor: AppInteraction {
    
    var allClues: [Clue]!
    var cluesPerRound: Int = 20
    
    init() {
        loadClues()
    }
    
    func getClues(count: Int, clueMethod: ClueMethod) -> [Clue] {
        var clues = [Clue]()

        let seedIndex = Int(arc4random_uniform(UInt32(allClues.count)))
        let seedClue = allClues[seedIndex]
        
        let filteredClues = allClues.filter {
            switch clueMethod {
            case .random:
                return true
            case .clueValue:
                return $0.value == seedClue.value
            case .jeopardyRound:
                return $0.round == seedClue.round
            case .showNumber:
                return $0.showNumber == seedClue.showNumber
            }
        }
        
        for _ in 0..<min(count, filteredClues.count) {
            let index = Int(arc4random_uniform(UInt32(filteredClues.count)))
            clues.append(filteredClues[index])
        }
        
        return clues
    }

    fileprivate func loadClues() {
        allClues = [Clue]()
        
        if let url = Bundle.main.url(forResource: "JeopardyClues", withExtension: "json") {
            if let data = NSData(contentsOf: url) {
                if let jsonObject = try? JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) {
                    if let jsonDict = jsonObject as? NSDictionary {
                        if let jsonArray = jsonDict["clues"] as? NSArray {
                            for json in jsonArray {
                                if let clue = Clue(json: json as? NSDictionary) {
                                    allClues.append(clue)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
