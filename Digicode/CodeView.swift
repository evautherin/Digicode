//
//  CodeView.swift
//  Digicode
//
//  Created by Etienne Vautherin on 31/03/2023.
//

import SwiftUI
import Firebase

struct CodeView: View {
    let code: Code
    
    var body: some View {
        Text("\(code.name)")
    }
}

struct CodeView_Previews: PreviewProvider {
    static var previews: some View {
        let code = Code(
            code: "B23A72",
            name: "Labo de test",
            location: GeoPoint(latitude: 48.8584, longitude: 2.2945)
        )
        
        CodeView(code: code)
    }
}
