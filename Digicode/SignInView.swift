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
//    @Binding var connected: Bool
    
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
                ViewModel.signIn(withEmail: email, password: password)
            })
        }
        .padding()
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
