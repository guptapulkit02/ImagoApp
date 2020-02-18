//
//  Extensions.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/12/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import Foundation
import UIKit

// MARK: UIView Extensions

extension UIView {
    
    // MARK: Public
    
    /// Description:- anchor function is used
    /// to set the constraints for the view for which
    /// this function is called. (Mainly UIView)
    /// - Parameter top: sets the top constraint view
    /// - Parameter left: sets the left constraint view
    /// - Parameter bottom: sets the bottom constraint view
    /// - Parameter right: sets the right constraint view
    /// - Parameter topConstant: sets the value for top
    /// - Parameter leftConstant: sets the value for left
    /// - Parameter bottomConstant: sets the value for bottom
    /// - Parameter rightConstant: sets the value for right
    /// - Parameter widthConstant: sets the width constant
    /// - Parameter heightConstant: sets the height constant
    
    public func anchor(
        _ top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0
    ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(
            top,
            left: left,
            bottom: bottom,
            right: right,
            topConstant: topConstant,
            leftConstant: leftConstant,
            bottomConstant: bottomConstant,
            rightConstant: rightConstant,
            widthConstant: widthConstant,
            heightConstant: heightConstant
        )
    }
    
    /// Description:- anchorWithReturnAnchors function is used
    /// to set the constraints for the view for which
    /// this function is called. (Mainly UIView)
    /// - Parameter top: sets the top constraint view
    /// - Parameter left: sets the left constraint view
    /// - Parameter bottom: sets the bottom constraint view
    /// - Parameter right: sets the right constraint view
    /// - Parameter topConstant: sets the value for top
    /// - Parameter leftConstant: sets the value for left
    /// - Parameter bottomConstant: sets the value for bottom
    /// - Parameter rightConstant: sets the value for right
    /// - Parameter widthConstant: sets the width constant
    /// - Parameter heightConstant: sets the height constant
    public func anchorWithReturnAnchors(
        _ top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
}
