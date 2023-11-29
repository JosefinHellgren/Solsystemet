//
//  BackButton.swift
//  Solsystemet
//
//  Created by josefin hellgren on 2023-11-15.
//

import Foundation
import SwiftUI

struct BackButton: View {
    @Binding var presentationMode: PresentationMode

    var body: some View {
        Button(action: {
            $presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left")
                .foregroundColor(Color.white)
        })
    }
}
