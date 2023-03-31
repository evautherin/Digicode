//
//  Annotation.swift
//  Digicode
//
//  Created by Etienne Vautherin on 31/03/2023.
//

import Foundation
import CoreLocation

enum Annotation: Identifiable {
    case userLocation(CLLocation)
    case code(Code)
    
    var id: String {
        switch self {
        case .userLocation(let location): return location.id
        case .code(let code): return code.id ?? ""
        }
    }
}


extension CLLocation: Identifiable {
    public var id: String { "\(coordinate.latitude):\(coordinate.longitude)"}
}
