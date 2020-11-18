//
//  String+Ext.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 19/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import Foundation

extension String {
    
    func convertToISODate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayDate() -> String {
        guard let date = self.convertToISODate() else { return "N/A" }
        return date.convertToString()
    }
}
