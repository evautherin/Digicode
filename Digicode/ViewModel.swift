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
import CoreLocation

class ViewModel: NSObject, ObservableObject {
    @Published var connected = (Auth.auth().currentUser != .none)
    @Published var user = Auth.auth().currentUser
    @Published var codes = [Code]()
    
    let locationManager = CLLocationManager()
    var subscriptions = Set<AnyCancellable>()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
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
        
    func addCard(from card: Code) {
        let db = Firestore.firestore()
        db.collection("codes").addDocument(from: card)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { _ in }
            .store(in: &subscriptions)
    }
    
    func removeCard(id: String) {
        let db = Firestore.firestore()
        db.collection("codes").document(id).delete()
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { }
            .store(in: &subscriptions)
    }
}


extension ViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeAuthorization")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
    }
}
