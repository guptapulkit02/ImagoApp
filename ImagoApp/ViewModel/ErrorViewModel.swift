//
//  ErrorViewModel.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/11/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import Foundation
import UIKit

// MARK:- ErrorViewModel

struct ErrorViewModel {
    
    
    // MARK:- Public
    
    let errorImage: UIImageView = {
        let imageView = UIImageView(image: Constants.errorImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    let errorMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    // Dependancy Injection (DI)
    init(error: ImageError) {
        
        switch error {
        case ImageError.NoNetwork:
            self.errorMessage.text = Constants.noConnectivityMessage
        default:
            self.errorMessage.text = Constants.errorMessage
        }
    }
}
