//
//  AppCordinator.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/29/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordination {
    func showStartView()
    func showQuestionView(clueMethod: ClueMethod)
    func showResultsView(results: [(score: Int, clue: Clue)])
}

final class AppCoordinator: AppCoordination {
    private let interactor: AppInteraction!
    private var navController: UINavigationController!
    private let storyboard: UIStoryboard!
    
    private let window: UIWindow!
    private var startViewController: StartViewController!
    
    init() {
        interactor = AppInteractor()
        
        navController = UINavigationController()
        navController.navigationBar.barStyle = .blackTranslucent
        navController.navigationBar.isHidden = true
        
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        UIApplication.shared.statusBarStyle = .lightContent

        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = getLaunchViewController()
        window.makeKeyAndVisible()
    }
    
    func getLaunchViewController() -> UIViewController {
        guard let vc = storyboard.instantiateViewController(withIdentifier: "launchViewController") as? LaunchViewController else { fatalError() }
        vc.configure(presenter: LaunchPresenter(coordinator: self))
        vc.navigationItem.setHidesBackButton(true, animated: true)
        
        navController.setViewControllers([vc], animated: true)
        return navController
    }
    
    func showStartView() {
        guard let vc = storyboard.instantiateViewController(withIdentifier: "startViewController") as? StartViewController else { fatalError() }
        vc.configure(presenter: StartPresenter(coordinator: self, interactor: interactor))
        vc.navigationItem.setHidesBackButton(true, animated: false)
        
        if startViewController == nil {
            startViewController = vc
            navController.pushViewController(vc, animated: true)
        }
        else {
            navController.popToViewController(startViewController, animated: true)
        }
    }
    
    func showQuestionView(clueMethod: ClueMethod) {
        guard let vc = storyboard.instantiateViewController(withIdentifier: "clueViewController") as? ClueViewController else { fatalError() }
        vc.configure(presenter: CluePresenter(coordinator: self, interactor: interactor, clueMethod: clueMethod))
        vc.navigationItem.setHidesBackButton(true, animated: false)
        
        navController.pushViewController(vc, animated: true)
    }
    
    func showResultsView(results: [(score: Int, clue: Clue)]) {
        guard let vc = storyboard.instantiateViewController(withIdentifier: "resultsViewController") as? ResultsViewController else { fatalError() }
        vc.configure(presenter: ResultsPresenter(coordinator: self, results: results))
        vc.navigationItem.setHidesBackButton(true, animated: false)
        
        navController.pushViewController(vc, animated: true)
    }
}
