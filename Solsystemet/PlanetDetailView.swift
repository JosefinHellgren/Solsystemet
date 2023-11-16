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
           backgroundImage
            ScrollView {
                VStack {
                    planetImage
                    cardView
                }
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(presentationMode: presentationMode))
    }
    @ViewBuilder var backgroundImage: some View {
        Image("stars_720")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
            .overlay( LinearGradient(
                gradient: Gradient(colors: [AppColors.green.opacity(0.3), Color.clear]),
                           startPoint: .top,
                           endPoint: .bottom
                       ))
    }
    @ViewBuilder var planetImage: some View {
        Image("\(planetName)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 300)
            .padding()
    }
    @ViewBuilder var cardView: some View {
        VStack(alignment: .leading) {
            Group {
                Text(planetName)
                    .font(.title)
                    .foregroundColor(AppColors.green)
                    .padding(.vertical)
                Text("""
Earth is the third planet from the Sun and the only astronomical object known to harbor life.
 This is enabled by Earth being a water world, the only one in the Solar System sustaining liquid surface water.
 Almost all of Earth's water is contained in its global ocean, covering 70.8% of Earth's crust.
 The remaining 29.2% of Earth's crust is land, most of which is located in the form of continental landmasses within one hemisphere, Earth's land hemisphere.
""")
                
            }.padding(.horizontal)
            horizontalMoons
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .roundedCorner(20, corners: [.topLeft, .topRight])
    }
    @ViewBuilder var horizontalMoons: some View {
        Text("Moons:").padding()
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
                        }.foregroundColor(Color.black)
                    }
                    )
                }
            }
            }.padding()
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
