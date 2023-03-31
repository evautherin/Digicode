//
//  ContentView.swift
//  Digicode
//
//  Created by Etienne Vautherin on 29/03/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseAuthCombineSwift
import MapKit

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var showingSheet = false
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.858400, longitude: 2.294500),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        NavigationStack {
            VStack {
//                List(viewModel.codes) { code in
//                    NavigationLink(code.name, value: code)
//                }
                Map(coordinateRegion: $mapRegion)
                
                Button("Sign Out", action: ViewModel.signOut)
            }
            .navigationDestination(for: Code.self) { code in
                CodeView(code: code)
            }
            .sheet(isPresented: $showingSheet) {
                SignInView()
            }
            .onReceive(viewModel.$connected) { connected in
                print("connected received")
                showingSheet = !connected
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
