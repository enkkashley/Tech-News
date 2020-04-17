//
//  SecondaryTitleLabel.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 15/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class TNSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontWeight: UIFont.Weight) {
        self.init(frame: .zero)
        font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 17, weight: fontWeight))
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textAlignment = .left
        textColor = .secondaryLabel
    }
}
