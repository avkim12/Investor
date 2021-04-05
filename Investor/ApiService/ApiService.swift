//
//  ApiService.swift
//  Investor
//
//  Created by chiwawa on 28.03.2021.
//

import UIKit


class ApiService {
    
    static let shared = ApiService()
    
    func fetchSnippets(completion: @escaping ([Snippet]) -> ()) {
        
        let urlString = "https://mboum.com/api/v1/co/collections/?list=most_actives&start=1&apikey=demo"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Error with fetching snippets: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
               let jsonStructure = try? JSONDecoder().decode(JSONStructure.self, from: data),
               let snippets = jsonStructure.snippets {
                
                DispatchQueue.main.async {
                    completion(snippets)
                }
            }
        }
        task.resume()
    }
}
