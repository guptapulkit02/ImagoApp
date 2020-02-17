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
    
    /// Description:- Delegate Function that is triggered when the response received from the API is valid and successfully parsed.
    /// - Parameter imageResponse: The parameter passes the response as a callback to the delegate and can be fetched by the calss implementing this delegate.
    func handleImageData(imageResponse: ImageViewModel) -> Void
    
    /// Description:- Delegate Function that is triggered when the response received from the API is not valid and not successfully parsed or there is some network error.
    /// - Parameter imageResponse: The parameter passes the error as a callback to the delegate and can be fetched by the class implementing this delegate.
    func handleImageError(imageError: ImageError) -> Void
    
}


// MARK:- Service

class Service {
    
    // Shared Instance
    static let shared = Service()
    
    weak var delegate: ImageServiceDelegate?
    
    
    // MARK:- Public: getImageData
    
    /// Description:- It gets the response from the URL that we call to get the description, Title and Image URl from the server using a URLSession.
    public func getImageData() {
        
        do {
            
            let network = try Utils.shared.isNetworkAvailable()
            let session = URLSession.shared
            let url = URL(string: Constants.serviceURLString)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            if network{
                let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
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
            self.delegate?.handleImageError(imageError: ImageError.ServerCallFailure)
            
        }
        
    }
    
    
    // MARK:- Private:
    
    private init() {}
    
    /// Description:- parseJSONString :- It is used to parse the string that we received as response from the API call and convert it into a JSON which can be easily utilised to get the description , title and image URL
    /// - Parameter data: a response received from the API call in the form of a string. 
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
