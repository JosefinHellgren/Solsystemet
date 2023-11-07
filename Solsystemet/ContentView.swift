//
//  ContentView.swift
//  Solsystemet
//
//  Created by josefin hellgren on 2023-11-07.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(networkManager.planets, id: \.id) { planet in
                            NavigationLink(destination: PlanetDetailView(
                                planetName: planet.englishName,
                                avgTemp: planet.avgTemp,
                                discoveredBy: planet.discoveredBy,
                                discoveredDate: planet.discoveryDate,
                                moons: planet.moons)) {
                                Image("\(planet.englishName)")
                                    .resizable()
                                    .frame(width: 300, height: 300)
                            }
                        }
                    }
                }.onAppear {
                    Task {
                        do { try await
                            networkManager.getAllPlanets()
                        } catch {
                            print("error\(error)")
                        }
                    }
                }
            }
        }
    }
}

struct PlanetDetailView: View {
    let planetName: String
    let avgTemp: Int
    let discoveredBy: String
    let discoveredDate: String
    let moons: [Moon]?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Image("\(planetName)")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("\(planetName)")
                    .font(.largeTitle)
                Text("Average Temperature: \(avgTemp)")
                Text("Discovered by: \(discoveredBy), \(discoveredDate)")
                Text("Moons:")
                    .font(.headline)
                ScrollView(.horizontal) {
                    HStack {
                        if let moons{
                            ForEach(moons,id: \.rel) { moon in
                                Text(moon.moon)
                            }
                        }
                    }
                }
            } .foregroundColor(Color.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
