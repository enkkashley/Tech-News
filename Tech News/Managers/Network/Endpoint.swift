//
//  Endpoint.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 19/10/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem]? = nil
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/\(path)"
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        print(url)
        return url
    }
}

extension Endpoint {
    static func domains() -> String {
        "arstechnica.com,engadget.com,recode.net,techcrunch.com,techradar.com,thenextweb.com,theverge.com,wired.com"
    }
    
    static func sources() -> String {
        "ars-technica,engadget,recode,techcrunch,techradar,the-next-web,the-verge,wired"
    }
}
