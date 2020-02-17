//
//  ModelTests.swift
//  ModelTests
//
//  Created by Infy MOBL on 2/13/20.
//  Copyright © 2020 Wayout. All rights reserved.
//

import XCTest

@testable import ImagoApp

class ModelTests: XCTestCase {

    let article = ImageInfo(title: "Artile Title", description: "dexcription text", imageHref: "https://")

    func testArticle() {

        XCTAssertEqual(article.title, "Artile Title", "title Proprty should not change post Initialization")
        XCTAssertEqual(article.description, "dexcription text", "description Proprty should not change post Initialization")
        XCTAssertEqual(article.imageHref, "https://", "imageHref Proprty should not change post Initialization")
    }

    func testAboutTitle() {

        let about = ImagoData(title: "About Canada", rows: [article])
        XCTAssertEqual(about.title, "About Canada", "title Proprty should not change post Initialization")
    }

    func testAboutRows() {

        let about = ImagoData(title: "About Canada", rows: [article])
        XCTAssertNotNil(about.rows, "rows Proprty should not change post Initialization")
    }

}
