//
//  ViewController.swift
//  ImagoApp
//
//  Created by Infy MOBL on 2/10/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import UIKit

// MARK:- AboutViewController

// Root View controller for Application landing screen

class ImageViewController: UITableViewController {

    // MARK:- Public
    
    var refresher: UIRefreshControl!
    var imageError: ImageError?
    var imageInfo: ImageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //code here
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.imageError != nil {
            let errorcell = tableView.dequeueReusableCell(withIdentifier: Constants.errorCellIdentifier, for: indexPath) as! ErrorCell
            return errorcell
        } else {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: Constants.imageInfoCellIdentifier, for: indexPath) as! ImagoTableViewCell
            return imageCell
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //code here
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //code here
    }
    
    
    private func setupView(){
        self.tableView?.backgroundColor = Constants.imagoBackgroundColor
        self.setupNavBar()
        self.tableView?.register(ImagoTableViewCell.self, forCellReuseIdentifier: Constants.imageInfoCellIdentifier)
        
        self.refresher = self.getRefreshControl()
        self.tableView.refreshControl = self.refresher
        
    }
    
    private func setupNavBar(){
        
    }
    
    private func getRefreshControl() -> UIRefreshControl {
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return rc
    }
    
    @objc private func handleRefresh() {
        
        Service.shared.getImageData()
        
    }
}

