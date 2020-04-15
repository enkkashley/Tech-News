//
//  TitleLabel.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 15/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class TNTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat, numberOfLines: Int) {
        self.init(frame: .zero)
        self.numberOfLines = numberOfLines
        font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: fontSize, weight: .heavy))
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textAlignment = .left
        textColor = .label
        lineBreakMode = .byTruncatingTail
    }
}
