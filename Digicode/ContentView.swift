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
    var body: some View {
        VStack {
            Button("Logout", action: {
                do {
                    try Auth.auth().signOut()
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
