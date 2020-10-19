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
    
    func getNews(page: Int, completed: @escaping (Result<Response, TNError>) -> Void) {
        
        let endpoint = Endpoint(path: "top-headlines", queryItems: [
            URLQueryItem(name: "sources", value: Endpoint.sources()),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apiKey", value: "API_KEY")
        ])
            
        let task = URLSession.shared.dataTask(with: endpoint.url) { (data, response, error) in
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
    
    func searchNews(with query: String, completed: @escaping (Result<Response, TNError>) -> Void) {
        
        let endpoint = Endpoint(path: "everything", queryItems: [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "domains", value: Endpoint.domains()),
//            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "apiKey", value: "API_KEY")
        ])

        let task = URLSession.shared.dataTask(with: endpoint.url) { (data, response, error) in
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

