//
//  Constants.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/10/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import Foundation
import UIKit

// MARK: Constants

struct Constants {
    
    // MARK: Public: Static
    
    static let navBarTitle = "Imago"
    static let noConnectivityMessage = "No Internet. Check your data/wifi settings and try again."
    static let errorMessage = "Something went wrong. Try again later."
    
    static let imageInfoCellIdentifier = "imageCell"
    static let errorCellIdentifier = "errorCell"
    
    static let serviceURLString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    static let errorImage = UIImage(named: "error")
    static let noImage = UIImage(named: "no-image")
    static let errorImageHeight = CGFloat(120)
    static let errorMargin = CGFloat(20)
    static let imageHeight = CGFloat(118)
    static let imageInsets = CGFloat(14)
    static let navigationTitleFontSize = CGFloat(20)
    static let navigationBarColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
    static let statusBarColor = UIColor(red: 194/255, green: 31/255, blue: 31/255, alpha: 1)
    static let imagoBackgroundColor = UIColor.white
    static let imageBackgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    static let imageNameColor = UIColor(red: 152/255, green: 0, blue: 0, alpha: 1)
    static let imageNameFont = UIFont.boldSystemFont(ofSize: 18)
    static let imageNameLines = 0
    static let imageDescriptionColor = UIColor(red: 65/255, green: 65/255, blue: 64/255, alpha: 1)
    static let imageDescriptionFont = UIFont.italicSystemFont(ofSize: 14)
    static let imageDescriptionLines = 0
    static let imageImageSize = CGFloat(100)
    
    // MARK: Private
    
    private init() {}
    
}
