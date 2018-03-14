//
//  Client.swift
//  PUBG
//
//  Created by Jonathan Baker on 3/14/18.
//  Copyright © 2018 Jonathan Baker. All rights reserved.
//

import Foundation

public class Client {

    // MARK: - Properties

    let baseRequest: URLRequest

    // MARK: - Initializers

    public init(apiKey: String) {
        assert(!apiKey.isEmpty, "The API key should not be empty.")

        let baseURL = URL(string: "https://api.playbattlegrounds.com/")!
        var baseRequest = URLRequest(url: baseURL)
        baseRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        baseRequest.setValue("application/vnd.api+json", forHTTPHeaderField: "Accept")
        self.baseRequest = baseRequest
    }
}
