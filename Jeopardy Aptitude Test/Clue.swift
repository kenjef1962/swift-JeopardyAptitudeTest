//
//  Question.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/21/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

struct Clue {
    var category: String
    var airDate: String
    var question: String
    var value: String
    var answer: String
    var round: String
    var showNumber: String
    
    init?(json: NSDictionary?) {
        guard let json = json else { return nil }
        
        category = json["category"] as? String ?? "---"
        airDate = json["air_date"] as? String ?? "---"
        question = json["question"] as? String ?? "---"
        value = json["value"] as? String ?? "---"
        answer = json["answer"] as? String ?? "---"
        round = json["round"] as? String ?? "---"
        showNumber = json["show_number"] as? String ?? "---"
    }
}
