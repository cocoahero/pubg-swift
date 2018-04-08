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

        do {
            let request = try client.requestWithRegion(.pcNorthAmerica, path: "matches")
            XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer abc123")
            XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/vnd.api+json")
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testRequestWithRegion() {
        let client = Client(apiKey: "abc123")

        do {
            let request = try client.requestWithRegion(.pcNorthAmerica, path: "matches")
            guard let url = request.url else {
                XCTFail("Request URL is missing")
                return
            }

            XCTAssertEqual(url.path, "/shard/pc-na/matches")
            XCTAssertEqual(url.query, "")
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testRequestWithParameters() {
        let client = Client(apiKey: "abc123")
        
        do {
            let request = try client.requestWithRegion(.xboxNorthAmerica, path: "matches/1337", parameters: ["sort": "createdAt"])
            guard let url = request.url else {
                XCTFail("Request URL is missing")
                return
            }

            XCTAssertEqual(url.path, "/shard/xbox-na/matches/1337")
            XCTAssertEqual(url.query, "sort=createdAt")
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
}
