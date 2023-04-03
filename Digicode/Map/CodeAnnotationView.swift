//
//  CodeAnnotationView.swift
//  Digicode
//
//  Created by Etienne Vautherin on 03/04/2023.
//

import SwiftUI

struct CodeAnnotationView: View {
    let code: Code
    
    var body: some View {
        NavigationLink(value: code) {
            Circle()
                .stroke(.red, lineWidth: 3)
                .frame(width: 44, height: 44)
        }
    }
}

struct CodeAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        CodeAnnotationView(code: Code.testCode)
    }
}
