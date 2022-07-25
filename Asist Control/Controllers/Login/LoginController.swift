//
//  LoginController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/1/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol LoginDelegate {
    func loginWasSuccessful()
    func loginFailed(with error: Error)
}

struct LoginController {
    
    var delegate: LoginDelegate?
    
    let db = FirebaseFirestore.Firestore.firestore()
    
    func logIn(email: String, password: String) {
        FirebaseService.shared.logInUser(email: email, pass: password) { result, error in
            if let error = error {
                delegate?.loginFailed(with: error)
                return
            }
            guard let result = result else { return }

            let userID = result.user.uid
            loadUser(with: userID)
        }
    }
    
    private func loadUser(with id: String) {
        FirebaseService.shared.getUser(with: id) { user in
            guard let user = user else { return }
            Current.shared.user = user
            delegate?.loginWasSuccessful()
        }
    }
    
}
