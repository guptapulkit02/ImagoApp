//
//  ErrorCell.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/11/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import UIKit
import SnapKit

class ErrorCell: UITableViewCell {

    
    
    // MARK:- Internal
    
    var aboutError: ErrorViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.setupCellView()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- Private: setupCellView
    
    private func setupCellView() {
        
        let imageView = (aboutError?.errorImage)!
        let errorLabel: UILabel = (aboutError?.errorMessage)!
        self.addSubview(imageView)
        self.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.left.equalTo(self).offset(Constants.errorMargin)
            make.right.equalTo(self).offset(-Constants.errorMargin)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.height.lessThanOrEqualTo(Constants.errorImageHeight)
            make.centerX.equalTo(self)
            make.left.equalTo(self).offset(Constants.errorMargin)
            make.right.equalTo(self).offset(-Constants.errorMargin)
            make.top.greaterThanOrEqualTo(Constants.errorMargin)
            make.bottom.equalTo(errorLabel.snp.top).offset(-Constants.errorMargin)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
