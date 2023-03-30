//
//  SignInView.swift
//  Digicode
//
//  Created by Etienne Vautherin on 30/03/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseAuthCombineSwift

struct SignInView: View {
    @Binding var connected: Bool
    
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
                        connected = true
                        print("\(result.user.uid)")
                    }
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(connected: .constant(true))
    }
}
