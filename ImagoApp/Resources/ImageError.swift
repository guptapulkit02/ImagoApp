//
//  ImageError.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/11/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import Foundation

// MARK: ImageError

enum ImageError: Error {
    
    case noNetwork
    case invalidJSON
    case serverCallFailure
}
