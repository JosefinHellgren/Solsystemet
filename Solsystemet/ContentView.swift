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
    @State private var scrollOffset: CGFloat = 0.0
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView(.horizontal) {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
