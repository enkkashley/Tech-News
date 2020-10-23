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
    let tableViewFooterView = TNLoadingView()
    var tableViewConfigured = false
    
    var articles = [Article]()
    var page = 1
    var hasMoreNews = true
    var networkManagerIsLoadingMoreNews = false
    
    var dataSource: UITableViewDiffableDataSource<Section, Article>!
    var searchQuery: String!
    
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
        searchController.searchBar.placeholder = "Search for news on any topic."
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.tag = 1
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.rowHeight = 78
        tableView.register(ArticleSearchResultCell.self, forCellReuseIdentifier: ArticleSearchResultCell.reuseIdentifier)
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, IndexPath, article -> UITableViewCell? in
            
            let articleSearchResultCell = tableView.dequeueReusableCell(withIdentifier: ArticleSearchResultCell.reuseIdentifier) as! ArticleSearchResultCell
            articleSearchResultCell.set(article: article)
            return articleSearchResultCell
        }
        
        tableViewConfigured = true
    }
    
    func setupUI(with response: Response) {
        // configure tableView once (i.e when tableViewConfigured is false)
        if !tableViewConfigured { configureTableView() }
        updateTableViewUI(with: response.articles)
    }
    
    
    func updateTableViewUI(with articles: [Article]) {
        if articles.count < 20 { self.hasMoreNews = false }
        
        page == 1 ? self.articles = articles : self.articles.append(contentsOf: articles)
 
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.articles)
        dataSource.apply(snapshot)
    }
    
    func removeTableView() {
        view.subviews.forEach { view in
            if view.tag == 1 {
                view.removeFromSuperview()
                tableViewConfigured = false
                
                page = 1
                hasMoreNews = true
            }
        }
    }
    
    func searchNews(with query: String, page: Int) {
        if page == 1 { showLoadingView() }
        networkManagerIsLoadingMoreNews = true
        
        NetworkManager.shared.searchNews(with: query, page: page) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if self.page == 1 {
                    self.dismissLoadingView()
                } else {
                    self.tableView.tableFooterView = nil
                }
                
                switch result {
                case .success(let response):
                    self.setupUI(with: response)
                case .failure(let error):
                    print(error)
                }
                
                self.networkManagerIsLoadingMoreNews = false
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        removeTableView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchQuery = searchBar.searchTextField.text!
        searchNews(with: searchQuery, page: page)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            if tableViewConfigured {
                removeTableView()
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = dataSource.itemIdentifier(for: indexPath) else { return }
        presentSafariViewController(with: article.url)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        // check if user has reached end of scroll
        if offsetY > contentHeight - scrollViewHeight {
            self.tableView.tableFooterView = tableViewFooterView
            // check if there're more news to be fetched and if the network manager isn't making any requests
            guard hasMoreNews, !networkManagerIsLoadingMoreNews else {
                // remove footerView if there's no more news
                self.tableView.tableFooterView = nil
                return
            }
            page += 1
            searchNews(with: searchQuery, page: page)
        }
    }
}
