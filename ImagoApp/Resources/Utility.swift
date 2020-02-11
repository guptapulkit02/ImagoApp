//
//  Utility.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/11/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

// MARK:- Utils

class Utils {
    
    public static let shared = Utils()
    
    // MARK:- Private
    
    private init() {}
    
    // MARK:- Public
    
    public func isNetworkAvailable() throws -> Bool {
        
        let reachability = NetworkReachabilityManager()
        if (reachability?.isReachable)! {
            return true
        } else {
            throw ImageError.NoNetwork
        }
    }
    
    public func parseData(data: String) throws -> ImagoData {
        
        // Since incoming data is not proper JSON need to remove \n & \t from the response
        var dataString = data.replacingOccurrences(of: "\n", with: "")
        dataString = data.replacingOccurrences(of: "\t", with: "")
        let data = dataString.data(using: String.Encoding.utf8)
        do {
            let imageData: ImagoData = try JSONDecoder().decode(ImagoData.self, from: data!)
            return imageData
        } catch {
            print(error)
            throw ImageError.InvalidJSON
        }
    }
    
    
    
}
