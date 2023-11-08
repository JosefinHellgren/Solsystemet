//
//  File.swift
//  
//
//  Created by josefin hellgren on 2023-11-08.
//

import Foundation

public struct CelestialBody: Codable {
    public let id: String
    public let name: String
    public let englishName: String
    public let isPlanet: Bool
    public let moons: [Moon]?
    public let discoveredBy: String
    public let discoveryDate: String
    public let avgTemp: Int
    public let bodyType: String
    public let rel: String
}
