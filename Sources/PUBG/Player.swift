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

    public let attributes: Attributes
}

extension Player {
    public struct Attributes: Decodable {

        public let name: String
    }
}
