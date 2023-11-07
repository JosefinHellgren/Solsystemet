//
//  NetworkManager.swift
//  Solsystemet
//
//  Created by josefin hellgren on 2023-11-07.
//

import Foundation

class NetworkManager : ObservableObject {
    
    @Published var planets : [CelestialBody] = []
    
    func getAllPlanets() async throws {
        
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


struct SolarSystemData: Codable {
    let bodies: [CelestialBody]
}

struct CelestialBody: Codable {
    let id: String
    let name: String
    let englishName: String
    let isPlanet: Bool
    let moons: [Moon]?
    let discoveredBy: String
    let discoveryDate: String
    let avgTemp: Int
    let bodyType: String
    let rel: String
}

struct Moon: Codable {
    let moon: String
    let rel: String
}



