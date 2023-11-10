//
//  PlanetDetailView.swift
//  Solsystemet
//
//  Created by josefin hellgren on 2023-11-07.
//

import Foundation
import SwiftUI
import SolarSystem

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
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text("\(planetName)")
                    .font(.largeTitle)
                Text("Average Temperature: \(avgTemp)")
                Text("Discovered by: \(discoveredBy), \(discoveredDate)")
                Text("Moons:")
                    .font(.headline)
                ScrollView(.horizontal) {
                    HStack { if let moons {
                        ForEach(moons, id: \.id) { moon in
                            NavigationLink(destination: {
                                ZStack {
                                    Color.black.ignoresSafeArea()
                                    VStack {
                                        Text("Name: \(moon.name)")
                                        Text("Discovered by: \(moon.discoveredBy)")
                                    }.foregroundColor(Color.white)
                                }
                            }, label: {
                                Text(moon.name)
                            }
                        )}
                    }
                    }
                }
            } .foregroundColor(Color.white)
        }
    }
}
struct PlanetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetDetailView(
            planetName: "Mercury",
            avgTemp: 170,
            discoveredBy: "Josefin Hellgren",
            discoveredDate: "Monday",
            moons: nil
        )
    }
}
