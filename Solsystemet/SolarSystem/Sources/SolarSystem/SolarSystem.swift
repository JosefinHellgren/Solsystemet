//
//  NetworkManager.swift
//  Solsystemet
//
//  Created by josefin hellgren on 2023-11-07.
//

import Foundation

public class SolarSystem: ObservableObject {
    
    enum SolarSystemError: Error {
        case failedToGetAllPlanets
    }
    @Published public var planets: [Planet] = []
    public init() {}
    public func updatePlanets() async throws {
        let internalPlanets: [Planet] = []
        do {
            guard let url = URL(string: "https://api.le-systeme-solaire.net/rest/bodies/") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            let solarSystemData = try JSONDecoder().decode(SolarSystemData.self, from: data)
            
            let celesticalDictionary = Dictionary(uniqueKeysWithValues: solarSystemData.bodies.map { ($0.name, $0) })
            let filteredPlanets = solarSystemData.bodies.filter { $0.isPlanet == true || $0.englishName.lowercased() == "sun" || $0.englishName.lowercased() == "pluto" }
            print(filteredPlanets.count)
            
            for planet in filteredPlanets {
                var newMoons: [Moon] = []
                if let moons = planet.moons {
                    for moon in moons {
                        if let moonBody = celesticalDictionary[moon.moon] {
                            let newMoon = Moon(
                                id: moonBody.id,
                                name: moonBody.englishName,
                                discoveredBy: moonBody.discoveredBy,
                                discoveredDate: moonBody.discoveryDate,
                                avgTemp: moonBody.avgTemp)
                            newMoons.append(newMoon)
                        }
                    }
                }
                let newPlanet = Planet(
                    name: planet.englishName,
                    discoveredDate: planet.discoveryDate,
                    id: planet.id,
                    discoveredBy: planet.discoveredBy,
                    avgTemp: Int(convertTemperature(temp: planet.avgTemp)),
                    moons: newMoons, mass: planet.mass, semimajorAxis: planet.semimajorAxis
                )
                await MainActor.run {
                    self.planets.append(newPlanet)
                }
            }
        } catch {
            print(error)
            throw SolarSystemError.failedToGetAllPlanets
        }
    }

    public func convertTemperature(temp: Int) -> Float {
        Float(temp) - 273.15
    }
}
