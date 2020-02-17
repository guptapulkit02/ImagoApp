//
//  ServiceTests.swift
//  ImagoAppTests
//
//  Created by Infy MOBL on 2/13/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import XCTest

@testable import ImagoApp

class ServiceTests: XCTestCase {

   private var serviceDataExpectation: XCTestExpectation!
    private var response: ImagoData!
    
    func testServiceURL() {
        
        XCTAssertEqual(Constants.serviceURLString, "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", "Invalid service URL.")
    }
    
    func testServiceData() {
        
        Service.shared.delegate = (self as! ImageServiceDelegate)
        serviceDataExpectation = expectation(description: "Response")
        
        Service.shared.getImageData()
        
        wait(for: [serviceDataExpectation], timeout: 60)
        XCTAssertNotNil(response, "Invalid Service Response")
    }
    
    func handleImageData(imageResponse: ImagoData) {
        
        response = imageResponse
        serviceDataExpectation.fulfill()
    }
    
    func handleImageError(imageError: ImageError) {
        
        serviceDataExpectation.fulfill()
    }

}
