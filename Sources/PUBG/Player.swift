//
//  Player.swift
//  PUBG-iOS
//
//  Created by Jonathan Baker on 4/11/18.
//  Copyright © 2018 Jonathan Baker. All rights reserved.
//

import Foundation

public struct Player: Decodable {

    // MARK: - Properties

    public let id: String

    public var name: String {
        return attributes.name
    }

    public var matches: [String] {
        return relationships.matches.data.map({ $0.id })
    }

    let attributes: Attributes

    let relationships: Relationships
}

extension Player {
    struct Attributes: Decodable {

        let name: String
    }
}

extension Player {
    struct Relationships: Decodable {

        let matches: MatchRelationship
    }
}

extension Player.Relationships {
    struct MatchRelationship: Decodable {

        let data: [Match]
    }
}

extension Player.Relationships.MatchRelationship {
    struct Match: Decodable {

        let id: String
    }
}
