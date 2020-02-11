//
//  ImageViewModel.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/11/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import Foundation
import UIKit


// MARK:- ImageViewModel

struct ImageViewModel {
    
    let title: String
    let rows: [InfoViewModel]
    
    init(imagoInfo: ImagoData) {
        
        var imagesArray: [InfoViewModel] = []
        
        if !(imagoInfo.rows?.isEmpty)! {
            for imageData in (imagoInfo.rows)! {
                guard let _ = imageData.title else { continue } // Ignoring images without Title
                let imageViewModel = InfoViewModel(info: imageData)
                imagesArray.append(imageViewModel)
            }
        }
        self.title = imagoInfo.title ?? ""
        self.rows = imagesArray
    }
    
}
