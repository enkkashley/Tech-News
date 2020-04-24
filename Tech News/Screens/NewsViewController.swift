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
    let tableViewFooterView = TNLoadingView()
    var articles = [Article]()
    var page = 1
    var hasMoreNews = true
    var networkManagerIsLoadingMoreNews = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getNews(page: page)
    }
    
    func getNews(page: Int) {
        if page == 1 { showLoadingView() }
        networkManagerIsLoadingMoreNews = true
        
        NetworkManager.shared.getNews(page: page) { [weak self] result in
            guard let self = self else { return }
            if page == 1 {
                self.dismissLoadingView()
            } else {
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                }
            }
            
            switch result {
            case .success(let response):
                self.updateUI(with: response)
                
            case .failure(let error):
                print(error)
            }

            self.networkManagerIsLoadingMoreNews = false
        }
    }
    
    func updateUI(with response: Response) {
        var response = response
        var articles = response.articles.manipulateDate()
        
        if articles.count < 20 { self.hasMoreNews = false }
        
        if page == 1 {
            // get first article from array for headerStoryView
            if let firstArticle = articles.first {
                self.updateHeaderStoryUI(with: firstArticle)
            }
            // removes first article from array and update tableView with remaining articles
            articles.remove(at: 0)
        }
        
        self.updateTableViewUI(with: articles)
    }
    
    func updateHeaderStoryUI(with article: Article) {
        DispatchQueue.main.async {
            let headerStoryView = TNHeaderStoryView()
            headerStoryView.set(headerStory: article)
            self.tableView.tableHeaderView = headerStoryView
        }
    }
    
    
    func updateTableViewUI(with articles: [Article]) {
        self.articles.append(contentsOf: articles)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        tableView.rowHeight = 150
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseIdentifier)
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleCell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseIdentifier, for: indexPath) as! ArticleCell
        let article = articles[indexPath.row]
        
        articleCell.set(article: article)
        
        return articleCell
    }
}

extension NewsViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        // check if user has reached end of scroll
        if offsetY > contentHeight - scrollViewHeight {
            self.tableView.tableFooterView = tableViewFooterView
            // check if there're more news to be fetched and if the network manager isn't making any requests
            guard hasMoreNews, !networkManagerIsLoadingMoreNews else {
                self.tableView.tableFooterView = nil
                return
            }
            page += 1
            getNews(page: page)
        }
    }
}

