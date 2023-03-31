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
import CoreLocation

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
                Map(
                    coordinateRegion: $mapRegion,
                    annotationItems: viewModel.annotations
                ) { annotation -> MapAnnotation<AnyView> in
                    let (coordinate, color): (CLLocationCoordinate2D, Color)
                    
                    switch annotation {
                    case .code(let code):
                        (coordinate, color) = (CLLocationCoordinate2D(
                            latitude: code.location.latitude,
                            longitude: code.location.longitude
                        ), .red)
                    case .userLocation(let location):
                        (coordinate, color) = (location.coordinate, .blue)
                    }
                    
                    return MapAnnotation(coordinate: coordinate) {
                        AnyView(
                            Circle()
                                .stroke(color, lineWidth: 3)
                                .frame(width: 44, height: 44)
                        )
                    }
                }
                
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
