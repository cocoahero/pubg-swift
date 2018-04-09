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

    @discardableResult
    public func match(withID id: String, region: Region, resultHandler: @escaping (Result<Data>) -> Void) -> URLSessionTask? {
        return executeRequest(region: region, path: "matches/\(id)", resultHandler: resultHandler)
    }

    @discardableResult
    public func player(withID id: String, region: Region, resultHandler: @escaping (Result<Data>) -> Void) -> URLSessionTask? {
        return executeRequest(region: region, path: "players/\(id)", resultHandler: resultHandler)
    }

    @discardableResult
    public func players(withIDs ids: [String], region: Region, resultHandler: @escaping (Result<Data>) -> Void) -> URLSessionTask? {
        return executeRequest(region: region, path: "players", parameters: ["filter[playerIds]": ids.joined(separator: ",")], resultHandler: resultHandler)
    }

    @discardableResult
    public func players(withNames names: [String], region: Region, resultHandler: @escaping (Result<Data>) -> Void) -> URLSessionTask? {
        return executeRequest(region: region, path: "players", parameters: ["filter[playerNames]": names.joined(separator: ",")], resultHandler: resultHandler)
    }

    @discardableResult
    public func status(resultHandler: @escaping (Result<Data>) -> Void) -> URLSessionTask? {
        return executeRequest(region: nil, path: "status", resultHandler: resultHandler)
    }

    // MARK: - Internal

    func executeRequest(region: Region?, path: String, parameters: [String: String] = [:], resultHandler: @escaping (Result<Data>) -> Void) -> URLSessionTask? {
        switch requestWithRegion(region, path: path, parameters: parameters) {
        case .success(let request):
            return executeRequest(request, resultHandler: resultHandler)
        case .failure(let error):
            resultHandler(.failure(error))
            return nil
        }
    }

    func executeRequest(_ request: URLRequest, resultHandler: @escaping (Result<Data>) -> Void) -> URLSessionTask {
        let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    resultHandler(.success(data))
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
        task.resume()
        return task
    }

    func requestWithRegion(_ region: Region?, path: String, parameters: [String: String] = [:]) -> Result<URLRequest> {
        var urlComponents = URLComponents(string: "https://api.playbattlegrounds.com/")!

        if let region = region?.rawValue {
            urlComponents.path = "/shard/\(region)/\(path)"
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
