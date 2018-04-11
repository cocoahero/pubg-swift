//
//  Match.swift
//  PUBG-iOS
//
//  Created by Jonathan Baker on 4/11/18.
//  Copyright © 2018 Jonathan Baker. All rights reserved.
//

import Foundation

public struct Match: Decodable {

    // MARK: - Properties

    public let id: String

    public var region: Region {
        return attributes.region
    }

    public var duration: TimeInterval {
        return attributes.duration
    }

    public var gameMode: String {
        return attributes.gameMode
    }

    public var mapName: String {
        return attributes.mapName
    }

    let attributes: Attributes
}

extension Match {
    struct Attributes: Decodable {

        let region: Region

        let mapName: String

        let gameMode: String

        let duration: TimeInterval
    }
}

extension Match.Attributes {
    private enum CodingKeys: String, CodingKey {
        case mapName
        case duration
        case gameMode
        case region = "shardId"
    }
}
