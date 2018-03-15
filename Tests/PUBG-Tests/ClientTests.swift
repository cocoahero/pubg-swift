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

    func testRequestWithRegion() {
        let client = Client(apiKey: "abc123")

        do {
            let request = client.requestWithRegion("pc-na", path: "matches")
            guard let url = request.url else {
                XCTFail("Request URL is missing")
                return
            }

            XCTAssertEqual(url.path, "/shard/pc-na/matches")
            XCTAssertEqual(url.query, "")
        }

        do {
            let request = client.requestWithRegion("xbox-na", path: "matches/1337", parameters: ["sort": "createdAt"])
            guard let url = request.url else {
                XCTFail("Request URL is missing")
                return
            }

            XCTAssertEqual(url.path, "/shard/xbox-na/matches/1337")
            XCTAssertEqual(url.query, "sort=createdAt")
        }
    }
}
