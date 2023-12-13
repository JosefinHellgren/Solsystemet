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
    @Published public var filteredPlanets: [Planet] = []
    @Published public var planets: [Planet] = []
    public init() {}
    public func tryNewApi() async throws {
        do {
            guard let url = URL(string: "http://localhost:3000/api/data") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            print("my planets\(data)")
            let solarSystem = try JSONDecoder().decode([Planet].self, from: data)
            await MainActor.run {
                self.planets = solarSystem
                self.filteredPlanets = planets
            }
        } catch {
            throw SolarSystemError.failedToGetAllPlanets
        }
    }
    public func convertTemperature(temp: Int) -> Float {
        Float(temp) - 273.15
    }
    public func searchPlanetsByname(query: String) {
        if query.isEmpty {
            filteredPlanets = planets
        } else {
            filteredPlanets = planets.filter({
                $0.planet.lowercased().contains(query.lowercased())
            })
        }
    }
}
