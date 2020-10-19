//
//  ArticleSearchResultCell.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 18/10/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class ArticleSearchResultCell: UITableViewCell {
    static let reuseIdentifier = "ArticleSearchResultCell"
    
    let padding: CGFloat = 12
    
    let articleImageView = TNImageView(frame: .zero)
    let sourceLabel = TNSecondaryTitleLabel(fontWeight: .bold, fontSize: 10)
    let titleLabel = TNTitleLabel(fontWeight: .bold, fontSize: 10, numberOfLines: 2)
    let timeLabel = TNSecondaryTitleLabel(fontWeight: .bold, fontSize: 10)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureImageView()
        configureSourceLabel()
        configureTitleLabel()
        configureTimeLabel()
    }
    
    private func configureImageView() {
        contentView.addSubview(articleImageView)
        
        NSLayoutConstraint.activate([
            articleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            articleImageView.heightAnchor.constraint(equalToConstant: 53),
            articleImageView.widthAnchor.constraint(equalToConstant: 57)
        ])
    }
    
    private func configureSourceLabel() {
        contentView.addSubview(sourceLabel)
        
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            sourceLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 9),
            sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            sourceLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 3),
            titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 9),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func configureTimeLabel() {
        contentView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            timeLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 9),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            timeLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    func set(article: Article) {
        articleImageView.downloadImage(fromURL: article.urlToImage)
        sourceLabel.text = article.source.name
        titleLabel.text = article.title
        timeLabel.text = article.publishedAt.convertToDisplayDate()
    }
}
