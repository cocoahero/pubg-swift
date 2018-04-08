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

    func testRequestHeaders() {
        let client = Client(apiKey: "abc123")

        switch client.requestWithRegion(.pcNorthAmerica, path: "matches") {
        case .success(let request):
            XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer abc123")
            XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/vnd.api+json")
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testRequestWithRegion() {
        let client = Client(apiKey: "abc123")

        switch client.requestWithRegion(.pcNorthAmerica, path: "matches") {
        case .success(let request):
            XCTAssertNotNil(request.url)
            XCTAssertEqual(request.url!.path, "/shard/pc-na/matches")
            XCTAssertEqual(request.url!.query, "")
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }

    func testRequestWithParameters() {
        let client = Client(apiKey: "abc123")

        switch client.requestWithRegion(.xboxNorthAmerica, path: "matches/1337", parameters: ["sort": "createdAt"]) {
        case .success(let request):
            let url = request.url
            XCTAssertNotNil(url)
            XCTAssertEqual(url!.path, "/shard/xbox-na/matches/1337")
            XCTAssertEqual(url!.query, "sort=createdAt")
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
}
