//
//  ArticleCell.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 17/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    static let reuseIdentifier = "ArticleCell"
    
    let padding: CGFloat = 12
    let articleImageView = TNImageView(frame: .zero)
    let sourceLabel = TNSecondaryTitleLabel(fontWeight: .bold)
    let titleLabel = TNTitleLabel(fontWeight: .bold,fontSize: 17, numberOfLines: 4)
    let timeLabel = TNSecondaryTitleLabel(fontWeight: .bold)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureArticleImageView()
        configureSourceLabel()
        configureTitleLabel()
        configureTimeLabel()
    }
    
    private func configureArticleImageView() {
        addSubview(articleImageView)
        
        NSLayoutConstraint.activate([
            articleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            articleImageView.widthAnchor.constraint(equalToConstant: 130),
            articleImageView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func configureSourceLabel() {
        addSubview(sourceLabel)
        
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            sourceLabel.trailingAnchor.constraint(equalTo: articleImageView.leadingAnchor, constant: -padding),
            sourceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.articleImageView.leadingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func configureTimeLabel() {
        addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            timeLabel.trailingAnchor.constraint(equalTo: articleImageView.leadingAnchor, constant: -padding),
            timeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(article: Article) {
        articleImageView.downloadImage(fromURL: article.urlToImage)
        sourceLabel.text = article.source.name
        titleLabel.text = article.title
        timeLabel.text = article.publishedAt
    }
}
