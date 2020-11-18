//
//  TNTabBarController.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 15/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class TNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createNewsNavigationController(), createSearchNavigationController()]
    }
    
    func createNewsNavigationController() -> UINavigationController {
        let newsViewController = NewsViewController()
        newsViewController.title = "Top Stories"
        newsViewController.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "doc.plaintext", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), tag: 0)
        
        return UINavigationController(rootViewController: newsViewController)
    }
    
    func createSearchNavigationController() -> UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        return UINavigationController(rootViewController: searchViewController)
    }
}
