//
//  ResultsViewController.swift
//  Jeopardy Aptitude Test
//
//  Created by Kendall Jefferson on 5/21/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var presenter: ResultsPresentation!
    
    func configure(presenter: ResultsPresentation) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        summaryLabel.text = presenter.getSummaryText()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        presenter.showStartView()
    }
}

extension ResultsViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultsViewCell.identifier, for: indexPath) as? ResultsViewCell else { return UITableViewCell() }
        cell.configure(result: presenter.results[indexPath.row])
        
        return cell
    }
}
