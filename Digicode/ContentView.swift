//
//  ContentView.swift
//  Digicode
//
//  Created by Etienne Vautherin on 29/03/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
//                List(viewModel.codes) { code in
//                    NavigationLink(code.name, value: code)
//                }
                
                MapView(annotations: $viewModel.annotations)
                Button("Sign Out", action: ViewModel.signOut)
                Spacer().frame(height: 20.0)
            }
            .navigationDestination(for: Code.self) { code in
                CodeView(code: code)
            }
            .navigationTitle("Digicode")
            .ignoresSafeArea()
            .sheet(isPresented: $viewModel.showingSignInView) {
                SignInView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
