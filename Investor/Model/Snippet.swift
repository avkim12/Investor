//
//  Snippet.swift
//  Investor
//
//  Created by chiwawa on 28.03.2021.
//

import UIKit

struct JSONStructure: Codable {
    
    let snippets: [Snippet]?
    
    private enum CodingKeys: String, CodingKey {
        
        case snippets = "quotes"
    }
}

struct Snippet: Codable {
    
    var symbol: String?
    var longName: String?
    var regularMarketPrice: Double?
    var regularMarketChange: Double?
    var regularMarketChangePercent: Double?
    var isFavorite: Bool = false
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        symbol = try container.decode(String.self, forKey: .symbol)
        longName = try container.decode(String.self, forKey: .longName)
        regularMarketPrice = try container.decode(Double.self, forKey: .regularMarketPrice)
        regularMarketChange = try container.decode(Double.self, forKey: .regularMarketChange)
        regularMarketChangePercent = try container.decode(Double.self, forKey: .regularMarketChangePercent)
    }
}
