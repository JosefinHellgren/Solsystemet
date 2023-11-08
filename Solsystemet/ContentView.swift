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
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView(.horizontal) {
                   planetsHorisontalView
                    
                }.onAppear {
                    Task {
                        do { try await
                            solarSystem.getAllPlanets()
                        } catch {
                            print("from contentView \(error)")
                        }
                    }
                }
                
            }
        }
    }
    @ViewBuilder var planetsHorisontalView: some View {
        HStack {
            ForEach(solarSystem.planets, id: \.id) { planet in
                NavigationLink(destination: PlanetDetailView(
                    planetName: planet.englishName,
                    avgTemp: planet.avgTemp,
                    discoveredBy: planet.discoveredBy,
                    discoveredDate: planet.discoveryDate,
                    moons: planet.moons)) {
                        Image("\(planet.englishName)")
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
