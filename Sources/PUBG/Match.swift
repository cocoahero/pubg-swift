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

    public var gameMode: GameMode {
        return attributes.gameMode
    }

    public var mapName: String {
        return attributes.mapName
    }

    public var timestamp: Date {
        return attributes.timestamp
    }

    let attributes: Attributes
}

extension Match {
    struct Attributes: Decodable {

        let region: Region

        let mapName: String

        let gameMode: GameMode

        let duration: TimeInterval

        let timestamp: Date
    }
}

extension Match.Attributes {
    private enum CodingKeys: String, CodingKey {
        case mapName
        case duration
        case gameMode
        case region = "shardId"
        case timestamp = "createdAt"
    }
}
