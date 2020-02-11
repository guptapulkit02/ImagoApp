//
//  ImagoModel.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/10/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import Foundation
import UIKit


// MARK:- ImagoData

// Making ImagoData Model Decodable so that JSON decoder can directly map service response accordingly

struct ImagoData: Decodable {
    
    let title : String?
    let rows: [ImageInfo]?

}
