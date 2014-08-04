//
//  WrapperTests.swift
//  Swiftagram
//
//  Created by Robert Manson on 8/2/14.
//  Copyright (c) 2014 Robert Manson. All rights reserved.
//

import UIKit
import XCTest

//TODO: Use old style parsing style

class WrapperTests: XCTestCase {
    let json: [String: AnyObject] = [
        "stat": "ok",
        "blogs": [
            "blog": [
                [
                    "id" : 73,
                    "name" : "Bloxus test",
                    "needspassword" : true,
                    "url" : "http://remote.bloxus.com/"
                ],
                [
                    "id" : 74,
                    "name" : "Manila Test",
                    "needspassword" : false,
                    "url" : "http://flickrtest1.userland.com/"
                ]
            ]
        ]
    ]
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testWrapper() {
        let wrapped = DictionaryWrap(dict: json)
        XCTAssert(wrapped.string("stat")! == "ok", "Stat matched")
        XCTAssert(wrapped.dictionary("blogs")?.array("blog")?.dictionary(0)?.int("id")! == 73, "First Blog Id")
        XCTAssert(wrapped.dictionary("blogs")?.array("blog")?.dictionary(1)?.string("name")! == "Manila Test", "First Blog Id")
    }
}
