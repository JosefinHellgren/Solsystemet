//
//  MoonDetailView.swift
//  Solsystemet
//
//  Created by josefin hellgren on 2023-11-13.
//

import SwiftUI

struct MoonDetailView: View {
    let moonName: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Name: \(moonName)")
               
            }.foregroundColor(Color.white)
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(presentationMode: presentationMode)
            )
    }
}
struct MoonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoonDetailView(moonName: "Moon")
    }
}
