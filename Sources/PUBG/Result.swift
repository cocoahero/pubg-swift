//
//  Result.swift
//  PUBG-iOS
//
//  Created by Jonathan Baker on 4/8/18.
//  Copyright © 2018 Jonathan Baker. All rights reserved.
//

/// A simple type to represent a result that can be either
/// successful or unsuccessful (failure).
public enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)

    // MARK: - Initializers

    init(value: Value) {
        self = .success(value)
    }

    init(error: Error) {
        self = .failure(error)
    }

    init(attempt: () throws -> Value) {
        do {
            self = .success(try attempt())
        }
        catch {
            self = .failure(error as! Error)
        }
    }
}
