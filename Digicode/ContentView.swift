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
    @StateObject var viewModel = ViewModel()
//    @State var connected = (Auth.auth().currentUser != .none)
    
    var body: some View {
        Group {
            
//            switch connected {
//            case true: Text("Connected")
//            case false: Text("Disconnected")
//            }
            
            if (viewModel.connected) { // viewModel.user != .none
                VStack {
                    Button("Sign Out", action: ViewModel.signOut)
                }
                .padding()
            } else {
                SignInView()
            }
        }
//        .onReceive(Auth.auth().authStateDidChangePublisher()) { user in
//            switch user {
//            case .none:
//                print("Disconnected")
//                connected = false
//
//            case .some(let user):
//                print("User \(user.uid) connected")
//                connected = true
//            }
//        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
