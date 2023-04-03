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
        Text("CodeView for \(code.name)")
    }
}

struct CodeView_Previews: PreviewProvider {
    static var previews: some View {
        CodeView(code: .testCode)
    }
}
