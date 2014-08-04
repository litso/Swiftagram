//
//  ResponseTests.swift
//  Swiftagram
//
//  Created by Robert Manson on 8/3/14.
//  Copyright (c) 2014 Robert Manson. All rights reserved.
//

import UIKit
import XCTest

class ResponseTests: XCTestCase {
    var json200: AnyObject?
    var json400: AnyObject?
    override func setUp() {
        super.setUp()
        json200 = readJSON("200")
        json400 = readJSON("400")
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func test200() {
        let response = HttpClient.Response(response: json200)
        switch response {
        case .Data(let result):
            XCTAssert(result.count == 2, "Result array count")
        case .Error(let error):
            XCTAssert(false, "Response should be Success")
        }
    }
    func test400() {
        let response = HttpClient.Response(response: json400)
        switch response {
        case .Data(let result):
            XCTAssert(false, "Response should be Error")
        case .Error(let error):
            XCTAssert(error.code == 400, "Error code should be 400")
        }
    }
    private func readJSON(filename: String) -> AnyObject? {
        let url = NSBundle(forClass: ResponseTests.self).URLForResource(filename, withExtension: "json")
        let data = NSData(contentsOfURL: url)
        var error: NSError?
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error)
        return json
    }
}
