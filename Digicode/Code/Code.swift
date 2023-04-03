//
//  Code.swift
//  Digicode
//
//  Created by Etienne Vautherin on 30/03/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Code: Codable, Hashable, Identifiable {
    @DocumentID var id: String?
    let code: String
    let name: String
    let location: GeoPoint    
}


extension Code {
    static let testCode = Code(
        code: "B23A72",
        name: "Labo de test",
        location: GeoPoint(latitude: 48.8584, longitude: 2.2945)
    )
}
