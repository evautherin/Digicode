//
//  MapView.swift
//  Digicode
//
//  Created by Etienne Vautherin on 03/04/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var annotations: [AnnotationItem]
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.858400, longitude: 2.294500),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    func annotationContent(annotation: AnnotationItem) -> MapAnnotation<AnyView> {
        switch annotation {
        case .code(let code):
            let coordinate = CLLocationCoordinate2D(
                latitude: code.location.latitude,
                longitude: code.location.longitude
            )
            return MapAnnotation(coordinate: coordinate) {
                AnyView(CodeAnnotationView(code: code))
            }

        case .userLocation(let location):
            return MapAnnotation(coordinate: location.coordinate) {
                AnyView(UserLocationAnnotationView())
            }
        }
        
    }
    
    var body: some View {
        Map(
            coordinateRegion: $mapRegion,
            annotationItems: annotations,
            annotationContent: annotationContent
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(annotations: .constant(AnnotationItem.testItems))
    }
}
