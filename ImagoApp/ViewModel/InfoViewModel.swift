//
//  InfoViewModel.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/11/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import Foundation
import UIKit

// MARK: InfoViewModel

struct InfoViewModel {
    
    // MARK: Public
    
    var title: String
    var imageURL: String
    var description: String
    
    // Dependancy Injection (DI)
    
    init(info: ImageInfo) {
        
        title = info.title!
        if let dscr = info.description {
            description = dscr
        } else {
            description = ""
        }
        if let url = info.imageHref {
            imageURL = url
        } else {
            imageURL = "http://"
        }
    }
    
    // Calculating Probable Height for Description text for given Card width
    
    /// - getDescriptionHeight(withWidth: CGFloat)->CGFloat - returns the height of the label it will occupy inside the cell.
    /// - Parameter withWidth: it is the width of the label that will contain the description
    func getDescriptionHeight(withWidth: CGFloat) -> CGFloat {

        let approxwidth = withWidth
        let size = CGSize(width: approxwidth, height: 1000)
        let estimatedFrame = NSString(string: description).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Constants.imageDescriptionFont], context: nil)
        return estimatedFrame.height
    }
}
