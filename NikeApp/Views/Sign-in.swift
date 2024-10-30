//
//  Sign-in.swift
//  NikeApp
//
//  Created by Lalit Kumar on 29/10/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct Sign_in: View {
    
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading = false
    
    @Environment(\.presentationMode) var dismiss
    
    var body: some View {
        NavigationStack {
            
            
            VStack(alignment: .leading, spacing: 40,content: {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss.wrappedValue.dismiss()
                    }
                
                
                VStack(alignment: .leading, spacing: 15, content: {
                    Text("Sign-In")
                        .font(.title)
                    
                    
                    Text("Enter your email address and password and continue shopping.")
                        .font(.callout)
                    
                })
                
                
                VStack(spacing: 15, content: {
                    TextField("Email Address", text: $email)
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(.gray.opacity(0.5))
                        .clipShape(Capsule())
                        .overlay{
                            Capsule()
                                .stroke(.gray.opacity(0.8), lineWidth: 0.5)
                        }
                    
                    
                    
                    
                    SecureField("Password", text: $password)
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(.gray.opacity(0.5))
                        .clipShape(Capsule())
                        .overlay{
                            Capsule()
                                .stroke(.gray.opacity(0.8), lineWidth: 0.5)
                        }
                })
                
                
                
                Spacer()
                
                // Login Button
                
                VStack(spacing: 15, content: {
                    
                    Button {
                        Auth.auth().signIn(withEmail: email, password: password){ (result, error)
                            in
                            
                            if error != nil {
                                print(error?.localizedDescription ?? "")
                                withAnimation() {
                                    isLoading.toggle()
                                }
                            } else {
                                // Now we collect user information and move to next view in app
                                // this we will do after sign view code.
                                
                                let db = Firestore.firestore()
                                db.collection("USERS").document(result?.user.uid ?? "").getDocument { document,error
                                    in
                                    
                                    if let document = document, document.exists {
                                        let name = document.get("User_Name") as? String ?? ""
                                        let email = document.get("Email") as? String ?? ""
                                        
                                        // Now we store collected name and email from firestore to local storage
                                        UserDefaults.standard.set(name, forKey: "NAME")
                                        UserDefaults.standard.set(email, forKey: "EMAIL")
                                        
                                        isLoading.toggle()
                                    }
                                    else {
                                        isLoading.toggle()
                                        print("Document Not Exist")
                                    }
                                }
                            }
                        }
                    } label : {
                        // when is processing data we show progress in button so we add
                        if !isLoading {
                            ProgressView()
                        } else {
                            Text("Continue")
                                .fontWeight(.semibold)
                            
                        }

                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.red)
                    .clipShape(Capsule())
                    .foregroundStyle(.white)
                    
                    
                    NavigationLink {
                        Sign_up()
                    } label: {
                        Text("Not having account? **Signup**")
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(.white)
                    
                    
                    
                })
            })
            .padding()
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    Sign_in()
}
