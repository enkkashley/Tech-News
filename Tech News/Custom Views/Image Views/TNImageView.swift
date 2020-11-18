//
//  FeaturedStoryImageView.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 15/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit
import SDWebImage

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
    }
    
    func downloadImage(fromURL url: String?) {
        guard let url = url else { return }
        
        sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "storyPlaceholder"))
        sd_imageTransition = .fade
    }
}
