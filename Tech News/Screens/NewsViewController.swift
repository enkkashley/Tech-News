//
//  ViewController.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 15/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
    
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    let headerStoryView = TNHeaderStoryView()
    let tableViewFooterView = TNLoadingView()
    var articles = [Article]()
    var page = 1
    var hasMoreNews = true
    var networkManagerIsLoadingMoreNews = false
    
    var dataSource: UITableViewDiffableDataSource<Section, Article>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getNews(page: page)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.frame = view.bounds
        tableView.rowHeight = 150
        
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseIdentifier)
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, article) -> UITableViewCell? in
            
            let articleCell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseIdentifier, for: indexPath) as! ArticleCell
            
            articleCell.set(article: article)
            return articleCell
        })
        
        configureRefreshControl()
    }
    
    func configureRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    @objc func handleRefresh() {
        page = 1
        getNews(page: page)
        refreshControl.endRefreshing()
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
            self.headerStoryView.set(headerStory: article)
//            self.headerStoryView.addTarget(self, action: #selector(self.handleHeaderStoryTapped), for: .touchUpInside)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleHeaderStoryTapped))
            self.headerStoryView.addGestureRecognizer(tapGesture)
            self.tableView.tableHeaderView = self.headerStoryView
        }
    }
    
    @objc func handleHeaderStoryTapped() {
        let urlString = headerStoryView.articleURL!

        guard let url = URL(string: urlString) else { return }

        let safariViewController = SFSafariViewController(url: url)

        present(safariViewController, animated: true)
    }
    
    func updateTableViewUI(with articles: [Article]) {
        if page == 1 {
            self.articles = articles
        } else {
            self.articles.append(contentsOf: articles)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.main])
        snapshot.appendItems(articles)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}

extension NewsViewController {
    enum Section {
        case main
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
                // remove footerView if there's no more news
                self.tableView.tableFooterView = nil
                return
            }
            page += 1
            getNews(page: page)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let urlString = articles[indexPath.row].url
        guard let url = URL(string: urlString) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true)
    }
}

