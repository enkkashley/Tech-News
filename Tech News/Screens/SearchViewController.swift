//
//  SearchVC.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 15/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let tableView = UITableView()
    var tableViewConfigured = false
    
    var dataSource: UITableViewDiffableDataSource<Section, Article>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.tag = 1
        tableView.frame = view.bounds
//        tableView.delegate = self
        tableView.rowHeight = 69
        tableView.register(ArticleSearchResultCell.self, forCellReuseIdentifier: ArticleSearchResultCell.reuseIdentifier)
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, IndexPath, article -> UITableViewCell? in
            
            let articleSearchResultCell = tableView.dequeueReusableCell(withIdentifier: ArticleSearchResultCell.reuseIdentifier) as! ArticleSearchResultCell
            articleSearchResultCell.set(article: article)
            return articleSearchResultCell
        }
        
        tableViewConfigured = true
    }
    
    func updateTableViewUI(with articles: [Article]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.main])
        snapshot.appendItems(articles)
        dataSource.apply(snapshot)
    }
    
    func setupUI(with response: Response) {
        // configure tableView once (i.e when tableViewConfigured is false)
        if !tableViewConfigured {
            configureTableView()
        }
        
        updateTableViewUI(with: response.articles)
    }
    
    func removeTableView() {
        view.subviews.forEach { view in
            if view.tag == 1 {
                view.removeFromSuperview()
                tableViewConfigured = false
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        removeTableView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchQuery = searchBar.searchTextField.text!
        
        showLoadingView()
        NetworkManager.shared.searchNews(with: searchQuery) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.dismissLoadingView()
                
                switch result {
                case .success(let response):
                    self.setupUI(with: response)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            if tableViewConfigured {
                removeTableView()
            }
        }
    }
}
