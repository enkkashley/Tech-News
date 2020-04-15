//
//  ViewController.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 15/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.tableHeaderView = TNFeaturedStoryView()
     }
}

