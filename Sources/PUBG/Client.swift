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

    let apiKey: String

    // MARK: - Initializers

    public init(apiKey: String) {
        self.apiKey = apiKey
    }

    // MARK: - Internal

    func requestWithRegion(_ region: Region, path: String, parameters: [String: String] = [:]) -> Result<URLRequest> {
        var urlComponents = URLComponents(string: "https://api.playbattlegrounds.com/")!

        urlComponents.path = "/shard/\(region.rawValue)/\(path)"
        urlComponents.queryItems = parameters.map({ URLQueryItem(name: $0, value: $1) })

        guard var request = urlComponents.url.map({ URLRequest(url: $0) }) else {
            return .failure(Error.invalidURL)
        }

        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.api+json", forHTTPHeaderField: "Accept")

        return .success(request)
    }
}

extension Client {
    public enum Error: Swift.Error {
        case invalidURL
        case unknown
    }
}
