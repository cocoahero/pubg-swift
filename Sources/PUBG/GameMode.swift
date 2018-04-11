//
//  GameMode.swift
//  PUBG-iOS
//
//  Created by Jonathan Baker on 4/11/18.
//  Copyright © 2018 Jonathan Baker. All rights reserved.
//

public enum GameMode: String, Decodable {
    
    /// Solo - First Person
    case soloFirstPerson = "solo-fpp"

    /// Solo - Third Person
    case soloThirdPerson = "solo"

    /// Duo - First Person
    case duoFirstPerson = "duo-fpp"

    /// Duo - Third Person
    case duoThirdPerson = "duo"

    /// Squad - First Person
    case squadFirstPerson = "squad-fpp"

    /// Squad - Third Person
    case squadThirdPerson = "squad"
}
