//
//  File.swift
//  
//
//  Created by josefin hellgren on 2023-11-10.
//

import Foundation

public protocol CelestialBody {
    var id: String { get }
    var name: String { get }
    var discoveredBy: String { get }
    var discoveredDate: String { get }
    var avgTemp: Int { get }
}
