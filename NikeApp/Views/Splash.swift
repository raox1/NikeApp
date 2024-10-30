//
//  Splash.swift
//  NikeApp
//
//  Created by Lalit Kumar on 24/10/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct Splash: View {
    
    @State var isActive = false
    
    var body: some View {
        VStack {
            if isActive{
                // Here if user is nil means user not signed in to app then they will move to Onboarding screen otherwise they direct to ContentView 
                if Auth.auth().currentUser != nil  {
                    ContentView()
                } else {
                    Onboarding()
                }
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
