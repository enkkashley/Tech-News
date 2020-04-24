//
//  TNLoadingView.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 23/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class TNLoadingView: UIView {
    
    let loadingLabel = TNSecondaryTitleLabel(fontWeight: .regular, fontSize: 15)
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureView()
        configureLoadingLabel()
        configureActivityIndicator()
    }
    
    private func configureView() {
        self.frame.size.height = 50
        backgroundColor = .systemBackground
    }
    
    private func configureLoadingLabel() {
        addSubview(loadingLabel)
        
        loadingLabel.text = "Loading Stories..."
        
        NSLayoutConstraint.activate([
            loadingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    private func configureActivityIndicator() {
        addSubview(activityIndicator)
    
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: loadingLabel.trailingAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        activityIndicator.startAnimating()
    }
}
