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
    
    private let iPadDevice: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
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
    
    public func getImageCellSize() -> CGSize {
        
        var size = CGSize()
        size.width = ((UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.width)! - (Constants.imageImageSize + Constants.imageInsets + 20))
        size.height = Constants.imageHeight
        return size
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

    public func isPortrait() -> Bool { // Checking manually since UIDevice.current.orientation.isPortrait don't work properly on device launch
        
        if UIScreen.main.bounds.size.height > UIScreen.main.bounds.size.width {
            return true
        }
        return false
    }
    
    public func getNavBarHidden() -> Bool {
        
        if self.iPadDevice { return false }
        else if self.isPortrait() { return false }
        else { return true }
    }
    
}
