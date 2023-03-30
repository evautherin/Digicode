//
//  ViewModel.swift
//  Digicode
//
//  Created by Etienne Vautherin on 30/03/2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import FirebaseAuth
import FirebaseAuthCombineSwift
import Combine

class ViewModel: ObservableObject {
    @Published var connected = (Auth.auth().currentUser != .none)
    @Published var user = Auth.auth().currentUser
    @Published var codes = [Code]()
    
    init() {
        Auth.auth().authStateDidChangePublisher()
            .map { user in
                switch user {
                case .none: return false
                case .some(_): return true
                }
            }
            .assign(to: &$connected)
        
        Auth.auth().authStateDidChangePublisher().assign(to: &$user)
        
        let db = Firestore.firestore()
        db.collection("codes")
            .snapshotPublisher()
            .tryMap { querySnapshot in
              try querySnapshot.documents.compactMap { documentSnapshot in
                try documentSnapshot.data(as: Code.self)
              }
            }
            .replaceError(with: [Code]())
            .handleEvents(receiveCancel: {
              print("Cancelled")
            })
            .print("*** Codes")
            .assign(to: &$codes)
    }
    
    static func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {(_, error) in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    static func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
