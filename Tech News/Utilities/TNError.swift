//
//  TNError.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 16/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import Foundation

enum TNError: Error {
    case invalidURL
    case invalidResponse
    case unableToSendRequest
    case unableToDecode
    case noDataReceived
}
