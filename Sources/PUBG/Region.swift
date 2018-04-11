//
//  Region.swift
//  PUBG-iOS
//
//  Created by Jonathan Baker on 4/8/18.
//  Copyright © 2018 Jonathan Baker. All rights reserved.
//

public enum Region: String, Decodable {
    /// PC Asia
    case pcAsia = "pc-as"

    /// PC North America
    case pcNorthAmerica = "pc-na"

    /// PC Europe
    case pcEurope = "pc-eu"

    /// PC Oceania
    case pcOceania = "pc-oc"

    /// PC Kakao
    case pcKakao = "pc-kakao"

    /// PC South East Asia
    case pcSouthEastAsia = "pc-sea"

    /// PC South & Central America
    case pcSouthCentralAmerica = "pc-sa"

    /// PC Korea & Japan
    case pcKoreaJapan = "pc-krjp"

    /// Xbox Asia
    case xboxAsia = "xbox-as"

    /// Xbox Europe
    case xboxEurope = "xbox-eu"

    /// Xbox North America
    case xboxNorthAmerica = "xbox-na"

    /// Xbox Oceania
    case xboxOceania = "xbox-oc"
}
