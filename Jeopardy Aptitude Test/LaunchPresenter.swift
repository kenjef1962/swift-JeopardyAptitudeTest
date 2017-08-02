//
//  LaunchPresenter.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/29/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

protocol LaunchPresentation {
    func showStartView()
}

final class LaunchPresenter: LaunchPresentation {
    fileprivate let coordinator: AppCoordination
    
    init(coordinator: AppCoordination) {
        self.coordinator = coordinator
    }
    
    func showStartView() {
        coordinator.showStartView()
    }
}
