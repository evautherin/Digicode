//
//  Annotation.swift
//  Digicode
//
//  Created by Etienne Vautherin on 31/03/2023.
//

import Foundation
import CoreLocation

enum Annotation {
    case userLocation(CLLocation)
    case code(Code)
}
