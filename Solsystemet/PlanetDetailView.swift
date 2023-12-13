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
    let averageTemperature: String
    let discoveredBy: String
    let moons: [String]?
    let planetInfo: String
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
                Text(planetInfo)
                    .padding(.vertical)
                Text("The average temperature on \(planetName) is \(avgTemp).")
                Text("Discovered by \(discoveredBy).")
            }.padding(.horizontal)
                .foregroundColor(Color.black)
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
                ForEach(moons, id: \.self) { moon in
                    NavigationLink(destination: {
                        MoonDetailView(moonName: moon)
                    }, label: {
                        VStack {
                            Image(systemName: "circle.fill")
                            Text(moon)
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
            avgTemp: "170",
            discoveredBy: "Josefin Hellgren",
            moons: nil,
            planetInfo: "the eart is big"
        )
    }
}
