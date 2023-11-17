//
//  ContentView.swift
//  Solsystemet
//
//  Created by josefin hellgren on 2023-11-07.
//

import SwiftUI
import SolarSystem

struct ContentView: View {
    @ObservedObject var solarSystem = SolarSystem()
    @State private var nameIsVisible = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView(.horizontal) {
                    planetsHorisontalView
                }.onAppear {
                    Task { if solarSystem.planets.isEmpty {
                        do { try await
                            solarSystem.updatePlanets()
                        } catch {
                            print("from contentView \(error)")
                        }
                    }}
                }
            }
        }
    }
    @ViewBuilder var planetsHorisontalView: some View {
        HStack {
            ForEach(solarSystem.planets.sorted(by: { $0.semimajorAxis < $1.semimajorAxis }), id: \.id) { planet in
                NavigationLink(destination: PlanetDetailView(
                    planetName: planet.name,
                    avgTemp: planet.avgTemp,
                    discoveredBy: planet.discoveredBy, discoveredDate: planet.discoveredDate,
                    moons: planet.moons)) {
                        Image("\(planet.name)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                    }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
