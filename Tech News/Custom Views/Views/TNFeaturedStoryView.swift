//
//  FeaturedStoryView.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 15/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class TNFeaturedStoryView: UIView {
    
    let padding: CGFloat = 12
    
    let storyImageView = TNFeaturedStoryImageView(frame: .zero)
    let sourceLabel = TNSecondaryTitleLabel()
    let titleLabel = TNTitleLabel(fontSize: 20, numberOfLines: 2)
    let timeLabel = TNSecondaryTitleLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureView()
        configureStoryImageView()
        configureSourceLabel()
        configureTitleLabel()
        configureTimeLabel()
    }
    
    private func configureView() {
        frame.size.height = 335
    }
    
    private func configureStoryImageView() {
        addSubview(storyImageView)
        
        NSLayoutConstraint.activate([
            storyImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            storyImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            storyImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            storyImageView.heightAnchor.constraint(equalToConstant: 204)
        ])
    }
    
    private func configureSourceLabel() {
        addSubview(sourceLabel)
        sourceLabel.text = "The Verge"
        
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor.constraint(equalTo: storyImageView.bottomAnchor, constant: 10),
            sourceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            sourceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            sourceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = "Now Nintendo Switch owners can move games from internal to external storage without downloading them again."
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configureTimeLabel() {
        addSubview(timeLabel)
        timeLabel.text = "2hrs ago"
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            timeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
