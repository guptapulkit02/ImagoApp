//
//  ImagoTableViewCell.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/10/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import UIKit

class ImagoTableViewCell: UITableViewCell {
    
    var imageInfo: InfoViewModel! {
        didSet {
            DispatchQueue.main.async {
                self.setupCellView()
            }
        }
    }
    
    let imageTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = Constants.imageNameLines
        label.textColor = Constants.imageNameColor
        label.font = Constants.imageNameFont
        return label
    }()
    
    let descriptionText: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = Constants.imageDescriptionLines
        label.textColor = Constants.imageDescriptionColor
        label.font = Constants.imageDescriptionFont
        return label
    }()
    
    let cellImage: LazyImageView = {
        // Placeholder Image till Image gets loaded successfully
        let view = LazyImageView(image: Constants.noImage)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /// Description:- it is used to setup the tableViewCell view . 
    private func setupCellView() {
        
        self.backgroundColor = Constants.imageBackgroundColor
        imageTitle.text = self.imageInfo.title
        descriptionText.text = self.imageInfo.description
        self.addSubview(self.imageTitle)
        self.addSubview(self.cellImage)
        self.addSubview(self.descriptionText)
        
        cellImage.anchor(
            self.topAnchor,
            left: self.leftAnchor,
            bottom: nil,
            right: nil,
            topConstant: 8, leftConstant: 8,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: Constants.imageImageSize,
            heightConstant: Constants.imageImageSize
        )
            
        imageTitle.anchor(
            self.cellImage.topAnchor,
            left: self.cellImage.rightAnchor,
            bottom: nil,
            right: self.rightAnchor,
            topConstant: 0,
            leftConstant: 12,
            bottomConstant: 8,
            rightConstant: 8,
            widthConstant: 0,
            heightConstant: 20
        )
            
        descriptionText.anchor(
            self.imageTitle.bottomAnchor,
            left: self.imageTitle.leftAnchor,
            bottom: nil,
            right: self.imageTitle.rightAnchor,
            topConstant: 8,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0
        )
        if !imageInfo.imageURL.isEmpty {
            cellImage.loadImageUsingURLString(urlString: imageInfo.imageURL)
        }
    }
    
}
