//
//  ImageViewControllerTableViewController.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/13/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import UIKit

class ImageViewControllerTableViewController: UITableViewController {
    
    // MARK:- Public
    
    var refresher: UIRefreshControl!
    var navigationTitle: UILabel?
    var imageError: ImageError?
    var imageInfo: ImageViewModel?
    var navBarView: UIView?
    
    // MARK:- Internal Inheritance UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
        print("Setup done...")
        Service.shared.delegate = self
        DispatchQueue.main.async {
            Service.shared.getImageData()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
            // Hiding navigation bar in case of iPhone device is in Lanscape mode
            self.navBarView?.isHidden = Utils.shared.getNavBarHidden()
        }) { (_) in }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.imageError != nil {
            let errorcell = tableView.dequeueReusableCell(withIdentifier: Constants.errorCellIdentifier, for: indexPath) as! ErrorCell
            let errorViewModel = ErrorViewModel(error: imageError!)
            errorcell.aboutError = errorViewModel
            return errorcell
        } else {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: Constants.imageInfoCellIdentifier, for: indexPath) as! ImagoTableViewCell
            imageCell.imageInfo = self.imageInfo?.rows[indexPath.row]
            return imageCell
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //code here
        if self.imageError != nil {return 1}
        else {
            return self.imageInfo?.rows.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightFinal : CGFloat
        let cellSize = Utils.shared.getImageCellSize()
        if self.imageError == nil {
            
            let descHeight = (self.imageInfo?.rows[indexPath.row].getDescriptionHeight(withWidth: cellSize.width))! + 46
            if descHeight > cellSize.height {
                 heightFinal = (descHeight - cellSize.height) + cellSize.height
            } else {
                heightFinal = cellSize.height
            }
            
        } else {
            heightFinal = self.tableView!.frame.width     //Making error cell full screen size
        }
        return heightFinal
    }
    
    
    private func setupView(){
        
        self.tableView?.backgroundColor = Constants.imagoBackgroundColor
        self.setupNavBar()
        self.tableView?.register(ImagoTableViewCell.self, forCellReuseIdentifier: Constants.imageInfoCellIdentifier)
        self.tableView?.register(ErrorCell.self, forCellReuseIdentifier: Constants.errorCellIdentifier)
        self.refresher = self.getRefreshControl()
        self.tableView.refreshControl = self.refresher
        
    }
    
    private func setupNavBar(){
        
        navigationController?.navigationBar.tintColor = .white
        self.navBarView?.isHidden = Utils.shared.getNavBarHidden()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationTitle = {
            let label = UILabel()
            label.text = Constants.navBarTitle
            label.textColor = UIColor.black
            label.textAlignment = .center
            label.frame.size.width = 200
            label.font = UIFont.systemFont(ofSize: Constants.navigationTitleFontSize)
            return label
        }()
        
        self.navigationItem.titleView = self.navigationTitle
        // Disabling Navigation to CardsView untill the data is available
    }
    
    private func getRefreshControl() -> UIRefreshControl {
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return rc
    }
    
    @objc private func handleRefresh() {
        DispatchQueue.main.async {
            Service.shared.getImageData()
        }
    }
    
    private func clearData() {
        
        if self.refresher.isRefreshing { self.refresher.endRefreshing() }
        self.imageInfo = nil
    }
    
}

// MARK:- AboutServiceDeligate

extension ImageViewControllerTableViewController: ImageServiceDelegate {
    
    func handleImageData(imageResponse: ImageViewModel) {
        
        DispatchQueue.main.async {
            self.clearData() // To handle fresh data from Pull to Refresh
            self.imageInfo = imageResponse
            self.navigationTitle?.text = self.imageInfo?.title
            self.navigationItem.titleView = self.navigationTitle
            self.navigationItem.rightBarButtonItem?.isEnabled = true // Since data is available enabling navigation to CardsView
            self.imageError = nil
            self.tableView?.reloadData()
        }
        
    }
    
    func handleImageError(imageError: ImageError) {
        
        self.clearData()
        self.imageError = imageError
        self.navigationItem.rightBarButtonItem?.isEnabled = false // Since data is not available disabling navigation to CardsView
        self.tableView?.reloadData()
    }
}
