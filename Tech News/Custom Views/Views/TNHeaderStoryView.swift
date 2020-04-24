//
//  FeaturedStoryView.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 15/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class TNHeaderStoryView: UIView {
    
    let padding: CGFloat = 12
    
    let articleImageView = TNImageView(frame: .zero)
    let sourceLabel = TNSecondaryTitleLabel(fontWeight: .heavy, fontSize: 17)
    let titleLabel = TNTitleLabel(fontWeight: .heavy,fontSize: 20, numberOfLines: 2)
    let timeLabel = TNSecondaryTitleLabel(fontWeight: .heavy, fontSize: 17)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureView()
        configureArticleImageView()
        configureSourceLabel()
        configureTitleLabel()
        configureTimeLabel()
    }
    
    private func configureView() {
        frame.size.height = 350
    }
    
    private func configureArticleImageView() {
        addSubview(articleImageView)
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            articleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            articleImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            articleImageView.heightAnchor.constraint(equalToConstant: 204)
        ])
    }
    
    private func configureSourceLabel() {
        addSubview(sourceLabel)
        
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10),
            sourceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            sourceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            sourceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configureTimeLabel() {
        addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            timeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(headerStory: Article) {
        articleImageView.downloadImage(fromURL: headerStory.urlToImage)
        sourceLabel.text = headerStory.source.name
        titleLabel.text = headerStory.title
        timeLabel.text = headerStory.publishedAt.convertToDisplayDate()
    }
}
