//
//  ViewModel.swift
//  Digicode
//
//  Created by Etienne Vautherin on 30/03/2023.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseAuthCombineSwift

class ViewModel: ObservableObject {
    @Published var connected = (Auth.auth().currentUser != .none)
    
    init() {
        Auth.auth().authStateDidChangePublisher()
            .map { user in
                switch user {
                case .none: return false
                case .some(_): return true
                }
            }
            .assign(to: &$connected)
    }
}
