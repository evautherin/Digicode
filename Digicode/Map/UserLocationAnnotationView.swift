//
//  UserLocationAnnotationView.swift
//  Digicode
//
//  Created by Etienne Vautherin on 03/04/2023.
//

import SwiftUI

struct UserLocationAnnotationView: View {
    var body: some View {
        Circle()
            .stroke(.blue, lineWidth: 3)
            .frame(width: 44, height: 44)
    }
}

struct UserLocationAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        UserLocationAnnotationView()
    }
}
