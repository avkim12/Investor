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
        
        guard let url = URL(string: "https://mboum.com/api/v1/co/collections/?list=most_actives&start=1&apikey=demo") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            if let data = data {
                if let jsonStructure = try? JSONDecoder().decode(JSONStructure.self, from: data) {
                    DispatchQueue.main.async {
                        completion(jsonStructure.snippets)
                    }
                    
                }
            }
        }.resume()
    }
}
