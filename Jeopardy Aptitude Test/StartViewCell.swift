//
//  StartViewCell.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/29/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit

class StartViewCell: UICollectionViewCell {
    
    @IBOutlet weak var methodLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            methodLabel.textColor = isSelected ? .white : .black
            backgroundColor = isSelected ? UIColor.init(red: 0.25, green: 0.5, blue: 0.75, alpha: 1) : .white
        }
    }
    
    func configure(method: String) {
        methodLabel?.text = method
        
        layer.cornerRadius = 10
        clipsToBounds = false
    }
    
    static let identifier = "startViewCell"
}
