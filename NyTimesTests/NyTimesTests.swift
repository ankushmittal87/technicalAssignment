//
//  NyTimesTests.swift
//  NyTimesTests
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import XCTest
@testable import NyTimes

class NyTimesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testAsyncCall() {
        let expactation = expectation(description: "Got the Most viewed article and count is greater than zero")
        let viewModal = ArticleListViewModal(manager: WebserviceManager())
        viewModal.loadArticles()
        viewModal.didFetchArticles = {
            XCTAssertGreaterThan(viewModal.articleCount, 1)
            expactation.fulfill()
        }
        waitForExpectations(timeout: TimeInterval(10)) { error in
            if let error = error {
                XCTFail("Timed out \(error.localizedDescription)")
            }
        }
    }

    func testViewModalPopulation() {
        let modal1 = MostViewed(status: "Ok",
                                results: [Result(adxKeywords: "This is a unit test to check numbers should be sine",
                                                 section: "A",
                                                 byline: "Ankush",
                                                 title: "Number Test",
                                                 abstract: "B",
                                                 publishedDate: "10-10-2010",
                                                 media: [Media(mediaMetadata: [MediaMetadata(url: "URL",height: 10,width: 10)])])])
        let viewModal = ArticleListViewModal(manager: WebserviceManager())
        viewModal.prepareDataForView(modal: modal1)
        XCTAssertEqual(viewModal.tableDataSource.count, 1)
    }
}
