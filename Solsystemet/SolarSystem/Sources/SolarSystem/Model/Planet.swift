//
//  File.swift
//
//
//  Created by josefin hellgren on 2023-12-13.
//

import Foundation

public struct Planet: Decodable {
    public let id: UUID = UUID()
    public let planet: String
    public let avgTempCelsius: String
    public let discoveredBy: String
    public let size: String
    public let moons: Int
    public let moonNames: [String]?
    public let info: String
}
