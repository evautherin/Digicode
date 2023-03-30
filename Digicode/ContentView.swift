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
    @State var connected = (Auth.auth().currentUser != .none)
    
    var body: some View {
        if (connected) {
            VStack {
                Button("Logout", action: {
                    do {
                        try Auth.auth().signOut()
                        connected = false
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                })
            }
            .padding()
        } else {
            SignInView(connected: $connected)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
