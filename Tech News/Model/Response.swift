//
//  Response.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 16/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import Foundation

struct Response: Decodable {
    let status: String
    let totalResults: Int
    var articles: [Article]
}
