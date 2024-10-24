//
//  Onboarding.swift
//  NikeApp
//
//  Created by Lalit Kumar on 24/10/24.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        ZStack {
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("onboarding_back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    Onboarding()
}
