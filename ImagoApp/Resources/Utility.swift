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

// MARK: Utils

class Utils {
    
    public static let shared = Utils()
    
    // MARK: Private
    
    private let iPadDevice: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    /// Description:- Any initial value that need to
    /// be passed to this class can be done using this constructor.
    private init() {}
    
    // MARK: Public
    
    /// Description:- it checks for the network
    /// availability using the NetworkReachibilityManager()
    /// class of Alamofire Pod.
    public func isNetworkAvailable() throws -> Bool {
        
        let reachability = NetworkReachabilityManager()
        if (reachability?.isReachable)! {
            return true
        } else {
            throw ImageError.noNetwork
        }
    }
    
    /// Description:- It return the size of the cell that has
    ///  to fit the image in that particular cell.
    ///  (It is calculated using the image size)
    public func getImageCellSize() -> CGSize {
        
        var size = CGSize()
        let winWidth = (UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.width)
        let imageViewSize = (Constants.imageImageSize + Constants.imageInsets + 20)
        size.width = (winWidth! - imageViewSize)
        size.height = Constants.imageHeight
        return size
    }
    
    /// Description:- parseData :- removes the unwanted
    /// spaces or text from the response and parses
    /// the response string into a JSON string
    /// - Parameter data: It is the response we received from the API call in form of a String.
    public func parseData(data: String) throws -> ImagoData {
        
        // Since incoming data is not proper JSON need to remove \n & \t from the response
        var dataString = data.replacingOccurrences(of: "\n", with: "")
        dataString = data.replacingOccurrences(of: "\t", with: "")
        let data = dataString.data(using: String.Encoding.utf8)
        do {
            let imageData: ImagoData = try JSONDecoder().decode(ImagoData.self, from: data!)
            return imageData
        } catch {
            throw ImageError.invalidJSON
        }
    }
    
    /// Description:- It checks if the orientation
    ///  of the device is portrait or not and if
    ///  it is then what needs to be done in that case.
    public func isPortrait() -> Bool {
        // Checking manually since UIDevice.current.orientation.isPortrait
        // don't work properly on device launch
        if UIScreen.main.bounds.size.height > UIScreen.main.bounds.size.width {
            return true
        }
        return false
    }
    
    /// Description:- It is a func that returns the bool
    /// value which tells whether er need to hide or show the navBar. 
    public func getNavBarHidden() -> Bool {
        
        if self.iPadDevice {
            return false
        } else if self.isPortrait() {
            return false
        } else {
            return true
        }
    }
    
}
