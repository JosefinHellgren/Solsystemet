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
    @State var searchText = ""
    @State var numberOfColumns = 2
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView(.vertical) {
                    planetsGridView
                }
                .scrollIndicators(.hidden)
                .padding()
                .onAppear {
                    Task { if solarSystem.planets.isEmpty {
                        do { try await
                            solarSystem.updatePlanets()
                        } catch {
                            print("from contentView \(error)")
                        }
                    }}
                }
                                .navigationTitle("Solar System")
                .navigationBarItems(trailing:
                                        Button(action: {
                    withAnimation {
                        toggleColumns()
                    }
                }, label: {
                    Image(systemName: numberOfColumns == 1 ? "square.grid.2x2" : "rectangle.grid.1x2")
                        .foregroundColor(.white)
                }))
            }
        } .environment(\.colorScheme, .dark)
    }
    private func toggleColumns() {
        numberOfColumns = numberOfColumns == 1 ? 2 : 1
    }
    @ViewBuilder var planetsGridView: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: numberOfColumns), spacing: 20) {
            ForEach(solarSystem.filteredPlanets, id: \.id) { planet in
                NavigationLink(
                    destination: PlanetDetailView(planetName: planet.name, avgTemp: planet.avgTemp, discoveredBy: planet.discoveredBy, discoveredDate: planet.discoveredDate, moons: planet.moons)
                ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).fill(Color.white).frame(maxWidth: .infinity)
                        VStack {
                            HStack {
                                Image("\(planet.name)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .offset(x: -30, y: -30)
                                    .mask(RoundedRectangle(cornerRadius: 20))
                                    .clipped()
                                    .allowsHitTesting(false)
                                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 2, y: 2)
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text(planet.name)
                                    .foregroundColor(Color.black)
                                    .font(.title)
                                    .padding()
                            }
                        }
                    }
                }
                               }
                               }
                    .searchable(text: $searchText)
                    .onChange(of: searchText) { newValue in
                        solarSystem.searchPlanetsByname(query: newValue)
                    }
                               }
                               }
                               struct ContentView_Previews: PreviewProvider {
                    static var previews: some View {
                        ContentView()
                    }
                }
