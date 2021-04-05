//
//  SnippetCell.swift
//  Investor
//
//  Created by chiwawa on 28.03.2021.
//

import UIKit

class SnippetCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deltaLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBAction func markAsFavourite(_ sender: UIButton) {
        
        if let isFavourite = snippet?.isFavorite {
            snippet!.isFavorite = !isFavourite
        }
    }
    
    var snippet: Snippet? {
        
        didSet {
            
            setupLogoImageView()
            setupTickerLabel()
            setupFavouriteButton()
            setupCompanyNameLabel()
            setupCurrentPriceLabel()
            setupDayDeltaLabel()
        }
    }
    
    private func setupLogoImageView() {
        
        if let symbol = snippet?.symbol {
            
            let urlString = "https://finnhub.io/api/logo?symbol=\(symbol)"
            
            logoImageView.loadImageUsingUrlString(urlString: urlString)
            logoImageView.layer.cornerRadius = 15
        }
    }
    
    private func setupTickerLabel() {
        
        if let symbol = snippet?.symbol {
            
            tickerLabel.text = symbol
        }
    }
    
    private func setupFavouriteButton() {
        
        if let isFavorite = snippet?.isFavorite,
           let favouriteButton = favouriteButton {
            favouriteButton.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
            favouriteButton.tintColor = isFavorite ? .systemYellow : .lightGray
        }
    }
    
    private func setupCompanyNameLabel() {
        
        if let longName = snippet?.longName {
            companyNameLabel.text = longName
        }
    }
    
    private func setupCurrentPriceLabel() {
        
        if let regularMarketPrice = snippet?.regularMarketPrice {
            priceLabel.text = "$\(String(format: "%.2f", regularMarketPrice))"
        }
    }
    
    private func setupDayDeltaLabel() {
        
        if let regularMarketChange = snippet?.regularMarketChange,
           let regularMarketChangePercent = snippet?.regularMarketChangePercent {
            
            let change = String(format: "%.2f", regularMarketChange)
            let changePercent = String(format: "%.2f", regularMarketChangePercent)
            
            deltaLabel.text = "$\(change) (\(changePercent)%)"
        }
    }
    
}
