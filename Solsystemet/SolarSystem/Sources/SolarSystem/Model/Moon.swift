//
//  File.swift
//  
//
//  Created by josefin hellgren on 2023-11-08.
//

import Foundation

public struct Moon: CelestialBody, Codable {
    public var id: String
    public var name: String
    public var discoveredBy: String
    public var discoveredDate: String
    public var avgTemp: Int
}
