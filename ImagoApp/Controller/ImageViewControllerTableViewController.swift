//
//  ImageViewControllerTableViewController.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/13/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import UIKit

class ImageViewControllerTableViewController: UITableViewController {
    
    // MARK: Public
    
    var navigationTitle: UILabel?
    var navBarView: UIView?
    
    // MARK: Private
    
    private var refresher: UIRefreshControl!
    private var imageError: ImageError?
    private var imageInfo: ImageViewModel?
    
    // MARK: Internal Inheritance UIView
    
    /// Description:- It loads the View initially before the view is going to appear on the window.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
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
        })
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if imageError != nil {
            let errorcell = tableView.dequeueReusableCell(withIdentifier: Constants.errorCellIdentifier, for: indexPath) as? ErrorCell
            let errorViewModel = ErrorViewModel(error: imageError!)
            errorcell!.aboutError = errorViewModel
            return errorcell!
        } else {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: Constants.imageInfoCellIdentifier, for: indexPath) as? ImagoTableViewCell
            imageCell!.imageInfo = imageInfo?.rows[indexPath.row]
            return imageCell!
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //code here
        if imageError != nil {
            return 1
        } else {
            return imageInfo?.rows.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightFinal: CGFloat
        let cellSize = Utils.shared.getImageCellSize()
        if imageError == nil {
            
            let descHeight = (imageInfo?.rows[indexPath.row].getDescriptionHeight(withWidth: cellSize.width))! + 46
            if descHeight > cellSize.height {
                 heightFinal = (descHeight - cellSize.height) + cellSize.height
            } else {
                heightFinal = cellSize.height
            }
            
        } else {
            heightFinal = tableView.frame.width     //Making error cell full screen size
        }
        return heightFinal
    }
    
    /// Description:- It sets the View initially.
    private func setupView() {
        
        tableView?.backgroundColor = Constants.imagoBackgroundColor
        setupNavBar()
        tableView?.register(ImagoTableViewCell.self, forCellReuseIdentifier: Constants.imageInfoCellIdentifier)
        tableView?.register(ErrorCell.self, forCellReuseIdentifier: Constants.errorCellIdentifier)
        refresher = getRefreshControl()
        tableView.refreshControl = refresher
        
    }
    
    /// Description:- It setups the Nav bar to support the view with the title
    private func setupNavBar() {
        
        navigationController?.navigationBar.tintColor = .white
        navBarView?.isHidden = Utils.shared.getNavBarHidden()
        navigationController?.navigationBar.isTranslucent = false
        navigationTitle = {
            let label = UILabel()
            label.text = Constants.navBarTitle
            label.textColor = UIColor.black
            label.textAlignment = .center
            label.frame.size.width = 200
            label.font = UIFont.systemFont(ofSize: Constants.navigationTitleFontSize)
            return label
        }()
        
        navigationItem.titleView = navigationTitle
        // Disabling Navigation to CardsView untill the data is available
    }
    
    /// Description:- it adds the refresh target to the view
    private func getRefreshControl() -> UIRefreshControl {
        
        let rControl = UIRefreshControl()
        rControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return rControl
    }
    
    /// Description :- It specifies what type of functionality the refresh will execute . here it will fetch the data again from the API service
    @objc private func handleRefresh() {
        DispatchQueue.main.async {
            Service.shared.getImageData()
        }
    }
    
    /// Description:- It is used to clear the data that was previously fetched and shown in the table view and show the latest fetched data
    private func clearData() {
        
        if refresher.isRefreshing { refresher.endRefreshing() }
        imageInfo = nil
    }
    
}

// MARK: AboutServiceDeligate

extension ImageViewControllerTableViewController: ImageServiceDelegate {
    
    /// Description:- it is the delegate method that returns the reponse that we have received from the APi in form of an array of type ImageViewModel
    /// - Parameter imageResponse: It accepts the value of type ImageViewModel.
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
    
    /// Description:- it is the delegate method that is triggered at the time of any error while retrieving the data form the API. It is also triggered at the time of network issue.
    /// - Parameter imageError: It contains the error description that is of type ImageError
    func handleImageError(imageError: ImageError) {
        
        clearData()
        self.imageError = imageError
        navigationItem.rightBarButtonItem?.isEnabled = false // Since data is not available disabling navigation to CardsView
        tableView?.reloadData()
    }
}
