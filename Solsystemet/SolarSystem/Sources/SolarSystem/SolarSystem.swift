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
        do {
            guard let url = URL(string: "https://api.le-systeme-solaire.net/rest/bodies/") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            let solarSystemData = try JSONDecoder().decode(SolarSystemData.self, from: data)
            print(solarSystemData.bodies)
            let filteredPlanets = solarSystemData.bodies.filter { $0.isPlanet == true }
            for planet in filteredPlanets {
                var newMoons: [Moon] = []
                if let moons = planet.moons {
                    for moon in moons {
                        let newnewMoons = solarSystemData.bodies.filter { $0.name == moon.moon }
                        for moon in newnewMoons {
                            let newMoon = Moon(
                                id: moon.id,
                                name: moon.englishName,
                                discoveredBy: moon.discoveredBy,
                                discoveredDate: moon.discoveryDate,
                                avgTemp: moon.avgTemp)
                            newMoons.append(newMoon)
                        }
                    }
                } else { // TODO: what should i do here when there are no moons?
                }
                let newPlanet = Planet(
                    name: planet.englishName,
                    discoveredDate: planet.discoveryDate,
                    id: planet.id,
                    discoveredBy: planet.discoveredBy,
                    avgTemp: Int(convertTemperature(temp: planet.avgTemp)),
                    moons: newMoons
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
