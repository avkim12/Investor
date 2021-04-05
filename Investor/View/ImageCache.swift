//
//  ImageCache.swift
//  Investor
//
//  Created by chiwawa on 04.04.2021.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingUrlString(urlString: String) {
        
        var imageUrlString: String?
        
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            
            self.image = imageFromCache
            return
            
        } else {
            
            self.image = #imageLiteral(resourceName: "photo3167064088017741762")
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data!) else { return }
                
                if imageUrlString == urlString {
                    
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
            }
            
        }).resume()
    }
}
