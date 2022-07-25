//
//  FirebaseService.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/2/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct FirebaseService {
    
    static let shared = FirebaseService()
    
    let auth = FirebaseAuth.Auth.auth()
    let firestore = FirebaseFirestore.Firestore.firestore()
    
    // MARK: - Login
    
    func logInUser(email: String, pass: String, completion: @escaping (AuthDataResult?, Error?) -> Void ) {
        auth.signIn(withEmail: email, password: pass) { result, error in
            
            guard let error = error else {
                completion(result, nil)
                return
            }
            completion(nil, error)
            print("Log in failed with error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Users
    func getUser(with id: String, completion: @escaping (User?) -> Void) {
        let docRef = firestore.collection("User").document(id)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let data = document.data() else { return }
                
                let user = User(for: id, with: data)
                completion(user)
            } else {
                print("There was a problem getting the document for user id: \(id)")
                completion(nil)
            }
        }
    }
    
    // MARK: - Employees
    func getEmployees(completion: @escaping ([Employee]) -> Void) {
        let docRef = firestore.collection("Employee")
        var employees = [Employee]()
        docRef.getDocuments() { querySnapshot, err in
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                documents.forEach { document in
                    let data = document.data()
                    let employee = Employee(data: data)
                    employees.append(employee)
                }
                completion(employees)
            } else {
                print("There was a problem getting the documents for Employees")
            }
        }
    }
    
    func getEmployee(with id: String, completion: @escaping (Employee?) -> Void) {
        let docRef = firestore.collection("Employee").document(id)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let data = document.data() else { return }
                
                let employee = Employee(data: data)
                completion(employee)
            } else {
                print("There was a problem getting the document for employee id: \(id)")
                completion(nil)
            }
        }
    }
    
    // MARK: - Trucks
    func getTrucks(completion: @escaping ([Truck]?) -> Void) {
        let collection = firestore.collection("Truck")
        var trucks: [Truck] = []
        collection.getDocuments { documents, error in
            if let documents = documents?.documents, !documents.isEmpty {
                documents.forEach { doc in
                    let data = doc.data()
                    
                    let truck = Truck(data: data)
                    trucks.append(truck)
                }
                completion(trucks)
            }
        }
    }
    
}
