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

    let urlSession: URLSession

    // MARK: - Initializers

    public init(apiKey: String, urlSession: URLSession = .shared) {
        self.apiKey = apiKey
        self.urlSession = urlSession
    }

    // MARK: - Public

    public func match(withID id: String, region: Region, resultHandler: @escaping (Result<Response<Match>>) -> Void) -> URLSessionTask? {
        return executeRequest(region: region, path: "matches/\(id)", resultHandler: resultHandler)
    }

    public func player(withID id: String, region: Region, resultHandler: @escaping (Result<Response<Player>>) -> Void) -> URLSessionTask? {
        return executeRequest(region: region, path: "players/\(id)", resultHandler: resultHandler)
    }

    public func players(withIDs ids: [String], region: Region, resultHandler: @escaping (Result<Response<[Player]>>) -> Void) -> URLSessionTask? {
        return executeRequest(region: region, path: "players", parameters: ["filter[playerIds]": ids.joined(separator: ",")], resultHandler: resultHandler)
    }

    public func players(withNames names: [String], region: Region, resultHandler: @escaping (Result<Response<[Player]>>) -> Void) -> URLSessionTask? {
        return executeRequest(region: region, path: "players", parameters: ["filter[playerNames]": names.joined(separator: ",")], resultHandler: resultHandler)
    }

    public func status(resultHandler: @escaping (Result<Response<Status>>) -> Void) -> URLSessionTask? {
        return executeRequest(region: nil, path: "status", resultHandler: resultHandler)
    }

    // MARK: - Internal

    func executeRequest<T>(region: Region?, path: String, parameters: [String: String] = [:], resultHandler: @escaping (Result<Response<T>>) -> Void) -> URLSessionTask? {
        switch requestWithRegion(region, path: path, parameters: parameters) {
        case .success(let request):
            return executeRequest(request, resultHandler: resultHandler)
        case .failure(let error):
            resultHandler(.failure(error))
            return nil
        }
    }

    func executeRequest<T>(_ request: URLRequest, resultHandler: @escaping (Result<Response<T>>) -> Void) -> URLSessionTask {
        let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    resultHandler(Result(attempt: {
                        try JSONDecoder().decode(Response<T>.self, from: data)
                    }))
                case 401:
                    resultHandler(.failure(Error.unauthorized))
                case 404:
                    resultHandler(.failure(Error.notFound))
                case 429:
                    resultHandler(.failure(Error.rateLimited))
                default:
                    resultHandler(.failure(Error.invalidStatusCode(response.statusCode)))
                }
            }
            else {
                resultHandler(.failure(error ?? Error.unknown))
            }
        })
        return task
    }

    func requestWithRegion(_ region: Region?, path: String, parameters: [String: String] = [:]) -> Result<URLRequest> {
        var urlComponents = URLComponents(string: "https://api.playbattlegrounds.com/")!

        if let region = region?.rawValue {
            urlComponents.path = "/shards/\(region)/\(path)"
        }
        else {
            urlComponents.path = "/\(path)"
        }
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
        case invalidStatusCode(Int)
        case unauthorized
        case notFound
        case rateLimited
        case unknown
    }
}
