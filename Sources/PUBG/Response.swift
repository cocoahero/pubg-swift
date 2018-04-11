//
//  Response.swift
//  PUBG-iOS
//
//  Created by Jonathan Baker on 4/11/18.
//  Copyright © 2018 Jonathan Baker. All rights reserved.
//

import Foundation

public struct Response<DataType: Decodable>: Decodable {

    // MARK: - Properties

    public let data: DataType

    public let links: [String: URL]
}
