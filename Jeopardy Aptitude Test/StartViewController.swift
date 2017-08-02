//
//  StartViewController.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/21/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit
import AVFoundation

class StartViewController: UIViewController, UICollectionViewDataSource, UITableViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    fileprivate var presenter: StartPresentation!
    fileprivate var player: AVAudioPlayer!
    
    func configure(presenter: StartPresentation) {
        self.presenter = presenter
        self.presenter.refreshView = { self.refreshView() }
        self.player = self.initSound(resource: "JeopardyBoard")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        segmentControl.selectedSegmentIndex = (presenter.cluesPerRound / 5) - 1
        refreshView()
    }
    
    @IBAction func randomizeButtonTapped(_ sender: UIButton) {
        player.currentTime = 1.0
        player.play()
        presenter.randomizeMethod()
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        player.stop()
        
        guard let selectedItems = collectionView.indexPathsForSelectedItems else { fatalError() }
        guard let clueMethod = ClueMethod(rawValue: selectedItems[0].row) else { fatalError() }
        
        presenter.showQuestionView(clueMethod: clueMethod)
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        presenter.cluesPerRound = (segmentControl.selectedSegmentIndex + 1) * 5
    }
}

extension StartViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ClueMethod.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartViewCell.identifier, for: indexPath) as? StartViewCell else { return UICollectionViewCell() }
        cell.configure(method: ClueMethod(rawValue: indexPath.row)!.stringValue)

        
        return cell
    }
}

extension StartViewController {
    func refreshView() {
        let indexPath = IndexPath(row: presenter.clueMethod.rawValue, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
    }
}
