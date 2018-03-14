//
//  ClientTests.swift
//  PUBG-Tests
//
//  Created by Jonathan Baker on 3/14/18.
//  Copyright © 2018 Jonathan Baker. All rights reserved.
//

import XCTest
@testable import PUBG

class ClientTests: XCTestCase {

    func testBaseRequest() {
        let baseRequest = Client(apiKey: "abc123").baseRequest

        XCTAssertEqual(baseRequest.value(forHTTPHeaderField: "Authorization"), "Bearer abc123")
        XCTAssertEqual(baseRequest.value(forHTTPHeaderField: "Accept"), "application/vnd.api+json")
    }
}
