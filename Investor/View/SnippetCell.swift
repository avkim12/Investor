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
    @IBAction func favouriteButton(_ sender: UIButton) {
        
    }
    
    
    
    var snippet: Snippet? {
        didSet {
            
            if snippet?.symbol != nil {

                let urlString = "https://finnhub.io/api/logo?symbol=\(String(describing: snippet!.symbol))"
                
                logoImageView.loadImageUsingUrlString(urlString: urlString)
                
//                func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//                    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//                }
//                
//                func downloadImage(from url: URL) {
//                    getData(from: url) { data, response, error in
//                        guard let data = data, error == nil else { return }
//                        print("Download Finished")
//                        DispatchQueue.main.async() { [weak self] in
//                            self?.logoImageView.image = UIImage(data: data)
//                        }
//                    }
//                }
//                
//                let url = URL(string: "https://finnhub.io/api/logo?symbol=\(String(describing: snippet!.symbol!))")!
//                downloadImage(from: url)
            }
            
            if snippet?.symbol != nil {
                tickerLabel.text = snippet?.symbol
            }
            
            if snippet?.longName != nil {
                companyNameLabel.text = snippet?.longName
            }
            
            if snippet?.regularMarketPrice != nil {
                priceLabel.text = "$\(String(snippet!.regularMarketPrice))"
            }
            
            if snippet?.regularMarketChange != nil && snippet?.regularMarketChangePercent != nil {
                let change = String(format: "%.2f", snippet!.regularMarketChange)
                let changePercent = String(format: "%.2f", snippet!.regularMarketChangePercent)
                deltaLabel.text = "$\(change) (\(changePercent)%)"
            }
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        setupLogoImageView()
//        setupTickerLabel()
//        setupFavouriteButton()
//        setupCompanyNameLabel()
//        setupCurrentPriceLabel()
//        setupDayDeltaLabel()
//    }
//
//    private func setupLogoImageView() {
//
//        logoImageView.layer.cornerRadius = 15
//    }
//
//    private func setupTickerLabel() {
//
//    }
//
//    private func setupFavouriteButton() {
//
//    }
//
//    private func setupCompanyNameLabel() {
//
//    }
//
//    private func setupCurrentPriceLabel() {
//
//    }
//
//    private func setupDayDeltaLabel() {
//
//    }
    
}
