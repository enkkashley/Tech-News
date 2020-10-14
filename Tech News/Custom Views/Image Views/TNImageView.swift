//
//  FeaturedStoryImageView.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 15/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class TNImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 8
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(named: "storyPlaceholder")
    }
    
    func downloadImage(fromURL url: String?) {
        guard let url = url else { return }
        
        NetworkManager.shared.downloadImage(fromURL: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
            
//                UIView.transition(with: self, duration: 3, options: .curveLinear, animations: {
                    self.image = image
//                })
            }
        }
    }
}
