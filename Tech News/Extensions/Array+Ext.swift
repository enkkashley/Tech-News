//
//  Array+Ext.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 20/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import Foundation

extension Array where Element == Article {
    // convert dates into appropriate .iso8601 format by manipulating the date string
    mutating func manipulateDate() -> [Article] {
        // loop through articles
        for (indexOfArticle, article) in self.enumerated() {
            // if article's date contains a "."
            if article.publishedAt.contains(".") {
                var date = article.publishedAt
                // get the index of "."
                let index = date.firstIndex(of: ".")!
                // create a substring from start of date to before "." appears.
                // convert substring to string for permanent storage and reassign to date variable
                date = String(date[..<index])
                // append "Z" character to date to make it an .iso8601 format
                date.append("Z")
                // reassign article's date the modified date
                self[indexOfArticle].publishedAt = date
            }
        }
        // return articles after manipulation
        return self
    }
}
