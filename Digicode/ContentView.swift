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
    
    func annotationContent(annotation: Annotation) -> MapAnnotation<AnyView> {
        switch annotation {
        case .code(let code):
            let coordinate = CLLocationCoordinate2D(
                latitude: code.location.latitude,
                longitude: code.location.longitude
            )
            return MapAnnotation(coordinate: coordinate) {
                AnyView(
                    NavigationLink {
                        Text(code.name)
                    } label: {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
                    }
                )
            }

        case .userLocation(let location):
            return MapAnnotation(coordinate: location.coordinate) {
                AnyView(
                    Circle()
                        .stroke(.blue, lineWidth: 3)
                        .frame(width: 44, height: 44)
                )
            }
        }
        
    }
    
    var body: some View {
        NavigationStack {
            VStack {
//                List(viewModel.codes) { code in
//                    NavigationLink(code.name, value: code)
//                }
                Map(
                    coordinateRegion: $mapRegion,
                    annotationItems: viewModel.annotations,
                    annotationContent: annotationContent
                )
                
                Button("Sign Out", action: ViewModel.signOut)
                
                Spacer()
                    .frame(height: 20.0)
                
            }
            .navigationDestination(for: Code.self) { code in
                CodeView(code: code)
            }
            .navigationTitle("Digicode")
            .ignoresSafeArea()
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
