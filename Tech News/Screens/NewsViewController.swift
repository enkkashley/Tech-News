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
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getNews(page: 1)
    }
    
    func getNews(page: Int) {
        NetworkManager.shared.getNews(page: page) { result in
            switch result {
            case .success(var response):
                // get first article from array for headerStoryView
                if let firstArticle = response.articles.first {
                    self.updateFeaturedStoryUI(with: firstArticle)
                }
                // removes first article from array and update tableView with remaining articles
                response.articles.remove(at: 0)
                self.updateTableViewUI(with: response.articles)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateTableViewUI(with articles: [Article]) {
        self.articles = articles
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func updateFeaturedStoryUI(with article: Article) {
        DispatchQueue.main.async {
            let headerStoryView = TNHeaderStoryView()
            headerStoryView.set(headerStory: article)
            self.tableView.tableHeaderView = headerStoryView
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
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
        let articleCell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseIdentifier) as! ArticleCell
        let article = articles[indexPath.row]
        
        articleCell.set(article: article)
        
        return articleCell
    }
}


