//
//  ApiService.swift
//  Investor
//
//  Created by Alla Kim on 28.03.2021.
//

import UIKit

class ApiService: NSObject {
    
    static let shared = ApiService()
    let url = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchSnippets(completion: @escaping ([Snippet]) -> ()) {
        fetchFeedForUrlString(urlString: "\(url)/home.json", completion: completion)
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Snippet]) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let snippets = try decoder.decode([Snippet].self, from: data)
                
                DispatchQueue.main.async {
                    completion(snippets)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            
        }.resume()
    }
}
