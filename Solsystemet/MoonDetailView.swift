//
//  MoonDetailView.swift
//  Solsystemet
//
//  Created by josefin hellgren on 2023-11-13.
//

import SwiftUI

struct MoonDetailView: View {
    let moonName: String
    let discoveredBy: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Name: \(moonName)")
                Text("Discovered by: \(discoveredBy)")
            }.foregroundColor(Color.white)
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
    }
}
struct MoonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoonDetailView(moonName: "Moon", discoveredBy: "Nasa")
    }
}
