//
//  ClueMethod.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/30/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

enum ClueMethod: Int {
    
    case random = 0
    case clueValue
    case jeopardyRound
    case showNumber
    
    var stringValue: String {
        switch self {
        case .random:
            return "Random"
        case .clueValue:
            return "Clue\nValue"
        case .jeopardyRound:
            return "Jeopardy!\nRound"
        case .showNumber:
            return "Show\nNumber"
        }
    }
    
    static var count: Int { return showNumber.rawValue + 1 }
}
