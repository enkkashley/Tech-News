//
//  NetworkManager.swift
//  Tech News
//
//  Created by Emmanuel Ashley on 16/04/2020.
//  Copyright © 2020 Emmanuel Ashley. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let baseURL = "https://newsapi.org/v2/"
    private let apiKey = "API_KEY"
    private let sources = "engadget,recode,techcrunch,techradar,the-next-web,the-verge,wired"
    
    
    
    func getNews(page: Int, completed: @escaping (Result<Response, TNError>) -> Void) {
        
        let endpoint = baseURL + "top-headlines?sources=\(sources)&apiKey=\(apiKey)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("Requesting")
            if error != nil {
                completed(.failure(.unableToSendRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.noDataReceived))
                return
            }
            print("Got Data")
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completed(.success(response))
            } catch {
                completed(.failure(.unableToDecode))
            }
        }
        
        task.resume()
    }
}

