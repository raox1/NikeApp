//
//  Sign-up.swift
//  NikeApp
//
//  Created by Lalit Kumar on 29/10/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct Sign_up: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isLoading = false
    @State private var errorMessage: String?

    @Environment(\.presentationMode) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 40) {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss.wrappedValue.dismiss()
                    }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Sign-Up")
                        .font(.title)
                    
                    Text("Enter your email address and password and continue shopping.")
                        .font(.callout)
                }
                
                VStack(spacing: 15) {
                    TextField("User name", text: $username)
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                        )
                    
                    TextField("Email Address", text: $email)
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                        )
                    
                    SecureField("Password", text: $password)
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                        )
                }
                
                Spacer()
                
                VStack(spacing: 15) {
                    Button {
                        signUp()
                    } label: {
                        if isLoading {
                            ProgressView()
                        } else {
                            Text("Continue")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.red)
                    .clipShape(Capsule())
                    .foregroundStyle(.white)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                    
                    NavigationLink {
                        Sign_in()
                    } label: {
                        Text("Already have an account? **Sign-in**")
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(.white)
                }
            }
            .padding()
            .preferredColorScheme(.dark)
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Sign-up Function
    func signUp() {
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required."
            return
        }
        
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = error.localizedDescription
                } else if let user = result?.user {
                    saveUserToFirestore(uid: user.uid)
                }
            }
        }
    }
    
    // MARK: - Save User to Firestore
    func saveUserToFirestore(uid: String) {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "User Name": username,
            "Email": email
        ]
        
        db.collection("USERS").document(uid).setData(data) { error in
            if let error = error {
                errorMessage = "Failed to save user: \(error.localizedDescription)"
            } else {
                UserDefaults.standard.setValue(uid, forKey: "UID")
                UserDefaults.standard.setValue(username, forKey: "NAME")
                UserDefaults.standard.setValue(email, forKey: "EMAIL")
                dismiss.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    Sign_up()
}
