//
//  Onboarding.swift
//  NikeApp
//
//  Created by Lalit Kumar on 24/10/24.
//

import SwiftUI

struct Onboarding: View {
    @State private var isActive: Bool = false

    var body: some View {
        
        if isActive {
            // We move to Login screen after that
        } else {
            // Design of This view
            ZStack(alignment: .top) {
                VStack {
                    Spacer()
                    // Add a red circle in bottom
                    Circle()
                        .fill(
                            RadialGradient(colors: [.red, .clear, .clear, .clear], center: .center, startRadius: 0, endRadius: UIScreen.main.bounds.width)
                        )
                        
                }
                .frame(height: .infinity)
                
                VStack(spacing: 15, content: {
                    Spacer()

                    Image("shoeob")
                        .resizable()
                        .scaledToFit()
                        
                    Text("Start Journey\nwith NIKE")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                    
                    Text("Smart gorgeous and fashionable collection make you cool")
                        .multilineTextAlignment(.center)
                        .opacity(0.6)
                    
                    Spacer()
                    
                    VStack {
                        Image("")
                    }
                })
                

            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("onboarding_back")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    Onboarding()
}
