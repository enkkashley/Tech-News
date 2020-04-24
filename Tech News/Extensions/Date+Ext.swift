//
//  Date+Ext.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 20/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.string(from: self)
    }
}
