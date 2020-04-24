//
//  ViewController+Ext.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 23/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

var loadingView: UIView!

extension UIViewController {
    
    func showLoadingView() {
        loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = .systemBackground
        
        view.addSubview(loadingView)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        loadingView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            loadingView.removeFromSuperview()
            loadingView = nil
        }
    }
}
