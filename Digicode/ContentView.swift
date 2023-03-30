//
//  ContentView.swift
//  Digicode
//
//  Created by Etienne Vautherin on 29/03/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseAuthCombineSwift

struct ContentView: View {
    @State var email = ""
    @State var password = ""

    var body: some View {
        VStack {
//            Text(password)
            TextField("e-mail", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)

            SecureField("Password", text: $password)
            
            Button("Login", action: {
                print("e-mail: \(email), password: \(password)")
                
                Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    
                    if let result = result {
                        print("\(result.user.uid)")
                    }
                }
            })
            
            Button("Logout", action: {
                do {
                    try Auth.auth().signOut()
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            })
        }
        .padding()
//        .onReceive(Auth.auth().authStateDidChangePublisher()) { user in
//            switch user {
//            case .none: print("Disconnected")
//            case .some(let user): print("User \(user.uid) connected")
//            }
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
