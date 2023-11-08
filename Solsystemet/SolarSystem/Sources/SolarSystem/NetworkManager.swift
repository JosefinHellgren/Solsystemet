//
//  NetworkManager.swift
//  Solsystemet
//
//  Created by josefin hellgren on 2023-11-07.
//

import Foundation

@available(iOS 13.0, *)
public class NetworkManager : ObservableObject {
    
    @Published public var planets : [CelestialBody] = []
    
    public init() {}
    
    public func getAllPlanets() async throws {
        
        do {
            guard let url = URL(string: "https://api.le-systeme-solaire.net/rest/bodies/") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let solarSystemData = try JSONDecoder().decode(SolarSystemData.self, from: data)
            
            let filteredPlanets = solarSystemData.bodies.filter { $0.isPlanet == true }
            
            await MainActor.run {
                self.planets = filteredPlanets
            }
            
        } catch {
            print("network error \(error)")
        }
    }
}


public struct SolarSystemData: Codable {
    public let bodies: [CelestialBody]
}

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

public struct Moon: Codable {
    public let moon: String
    public let rel: String
}



