//
//  File.swift
//  
//
//  Created by josefin hellgren on 2023-11-10.
//

import Foundation

public struct Planet: CelestialBody {
    public var name: String
    public var discoveredDate: String
    public let id: String
    public let discoveredBy: String
    public let avgTemp: Int
    public let moons: [Moon]?
}
