//
//  Annotation.swift
//  Digicode
//
//  Created by Etienne Vautherin on 31/03/2023.
//

import Foundation
import CoreLocation

enum AnnotationItem {
    case userLocation(CLLocation)
    case code(Code)
    
}


extension AnnotationItem: Identifiable {
    var id: String {
        switch self {
        case .userLocation(let location):
            let coordinate = location.coordinate
            return "\(coordinate.latitude):\(coordinate.longitude)"
            
        case .code(let code): return code.id ?? ""
        }
    }
}


extension AnnotationItem {
    static let testItems = [
        AnnotationItem.userLocation(
            CLLocation(
                latitude: 48.861596,
                longitude: 2.289282
            )
        ),
        AnnotationItem.code(.testCode)
    ]
}
