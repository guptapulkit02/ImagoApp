//
//  Service.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/11/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Protocol: ImageServiceDelegate

protocol ImageServiceDelegate: class {
    func handleImageData(imageResponse: ImageViewModel) -> Void
    func handleImageError(imageError: ImageError) -> Void
}


// MARK:- Service

class Service {
    
    // Shared Instance
    static let shared = Service()
    
    var delegate: ImageServiceDelegate?
    
    
    // MARK:- Public: getImageData
    
    public func getImageData() {
        
        do {
            
            let network = try Utils.shared.isNetworkAvailable()
            let session = URLSession.shared
            let url = URL(string: Constants.serviceURLString)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            if network{
                let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                    print(response!)
                    do{
                        if let receivedData = data {
                            let returnData: String = String(decoding: receivedData, as: UTF8.self)
                            self.parseJSONString(data: returnData)
                        } else {
                            self.delegate?.handleImageError(imageError: ImageError.ServerCallFailure)
                        }
                        
                    }
                })
                task.resume()
            }
            
        } catch ImageError.NoNetwork{
            
            self.delegate?.handleImageError(imageError: ImageError.NoNetwork)
            
        } catch ImageError.InvalidJSON {
            
            self.delegate?.handleImageError(imageError: ImageError.InvalidJSON)
            
        } catch {
            
            print(error.localizedDescription)
            self.delegate?.handleImageError(imageError: ImageError.ServerCallFailure)
            
        }
        
    }
    
    
    // MARK:- Private:
    
    private init() {}
    
    private func parseJSONString(data: String) {
        do {
            let imageData = try Utils.shared.parseData(data: data)
            let imageViewModel = ImageViewModel(imagoInfo: imageData)
            self.delegate?.handleImageData(imageResponse: imageViewModel)
        } catch {
            self.delegate?.handleImageError(imageError: ImageError.InvalidJSON)
        }
    }
}
