//
//  UtilsTests.swift
//  ImagoAppTests
//
//  Created by Infy MOBL on 2/13/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import XCTest

@testable import ImagoApp

class UtilsTests: XCTestCase {

    func testNetwork() {
        do {
            let result = try Utils.shared.isNetworkAvailable()
            XCTAssertEqual(result, true, "No Internet")
        } catch {
            XCTFail("Failed")
        }
    }
    func testInvalidJSONParsing() {
        do {
            _ = try Utils.shared.parseData(data: "{\"title\", \"About Canada\", \"rows\", []}")
            XCTFail("Failed")
        } catch {
            XCTAssertEqual(error as? ImageError, ImageError.invalidJSON)
        }
    }
    func testParsingJSONString() {
        do {
            let result = try Utils.shared.parseData(data: "{\"title\": \"About Canada\", \"rows\": []}")
            XCTAssertEqual(result.title, "About Canada")
        } catch {
            XCTFail("Failed")
        }
    }

}
