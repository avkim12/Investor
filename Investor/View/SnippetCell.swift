//
//  SnippetCell.swift
//  Investor
//
//  Created by Alla Kim on 28.03.2021.
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLogoImageView()
        setupTickerLabel()
        setupFavouriteButton()
        setupCompanyNameLabel()
        setupCurrentPriceLabel()
        setupDayDeltaLabel()
    }

    private func setupLogoImageView() {
        
        logoImageView.layer.cornerRadius = 10
    }
    
    private func setupTickerLabel() {
        
    }
    
    private func setupFavouriteButton() {
        
    }
    
    private func setupCompanyNameLabel() {
        
    }
    
    private func setupCurrentPriceLabel() {
        
    }
    
    private func setupDayDeltaLabel() {
        
    }

}
