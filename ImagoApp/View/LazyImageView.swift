//
//  LazyImageView.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/10/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import UIKit

// Image Cache to limit unnecessory Network calls
let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: LazyImageView

class LazyImageView: UIImageView {
    
    // MARK: Private
    
    private var imageURLString: String?
    
    // MARK: Public
    
    /// Description :-  It clears the Cache memory that stores the already fetched images
    static func clearImageCache() {
        
        imageCache.removeAllObjects()
    }
    
    /// Description : - It loads the images in the background from the URL String that is passed to this function
    /// - Parameter urlString: It is the URL of the image that has to be downloaded to be shown in the table view
    func loadImageUsingURLString(urlString: String) {
        
        imageURLString = urlString // Holding Image URL to make sure Image gets in Right Place during Async Calls
        self.image = Constants.noImage // Placeholder Image till Actual Image gets loaded Successfully
        let url = URL(string: urlString)!
        
        // Returning Imaage if available in Cache
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        // Since Image is not Available in Cache, fetching it from URL
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    return
                }
                if response != nil {
                    let httpResponse = response as? HTTPURLResponse
                    
                    // Checking for Success Response
                    if data != nil && httpResponse!.statusCode == 200 {
                        let imageToCache = UIImage(data: data!)
                        
                        // Checking if current Image URL is same as Holding URL
                        if self!.imageURLString == urlString && imageToCache != nil {
                            self!.image = UIImage(data: data!)
                            imageCache.setObject(imageToCache as AnyObject, forKey: self!.imageURLString as AnyObject)
                        }
                    }
                }
            }
        }).resume()
    }
}
