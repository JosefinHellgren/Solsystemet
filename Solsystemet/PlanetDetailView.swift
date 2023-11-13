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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                    .frame(width: 400, height: 400)
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
                                MoonDetailView(moonName: moon.name, discoveredBy: moon.discoveredBy)
                              
                            }, label: {
                                VStack {
                                    Image(systemName: "circle.fill")
                                    Text(moon.name)
                                }
                            }
                        )}
                    }
                    }.padding()
                }.navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading:
                        Button(action: {
                            // Handle custom back button action
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                        HStack {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(Color.white)
                                    .imageScale(.large)
                            }
                        }
                    )

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
