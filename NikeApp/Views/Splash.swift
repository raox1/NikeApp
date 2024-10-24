//
//  Splash.swift
//  NikeApp
//
//  Created by Lalit Kumar on 24/10/24.
//

import SwiftUI

struct Splash: View {
    
    @State var isActive = false
    
    var body: some View {
        VStack {
            if isActive{
                Onboarding()
            } else {
                Text("NIKE")
                    .font(.largeTitle.bold())
            }

        }
        .onAppear(){
            // We move to onboarding screen after 2.5 secs
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                isActive = true
            }
        }
    }
}

#Preview {
    Splash()
}
