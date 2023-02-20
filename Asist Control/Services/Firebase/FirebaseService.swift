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
    let docRef = firestore.collection(K.Firebase.user).document(id)
    
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
  
  // MARK: - Trucks
  func getTrucks(completion: @escaping ([Truck]?) -> Void) {
    let collection = firestore.collection(K.Firebase.truck)
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

  func uploadTrucksForToday(_ trucks: [Truck]) {
    let today = getTodaysDate()
    trucks.forEach { truck in
      firestore.collection("\(K.Firebase.wages)/\(today)").document(truck.id).setData([
        "driver": truck.driverId,
        "assistant_one": truck.assistant1?.ci ?? "",
        "assistant_two": truck.assistant2?.ci ?? "",
      ])
    }
  }

  func uploadSingleTruck(_ truck: Truck, completion: (Bool) -> Void) {
    guard truck.assistantsIds.count > 1 else { return print("Truck \(truck.id) was missing \(2 - truck.assistantsIds.count) assistant(s)") }
      
    firestore.collection("\(K.Firebase.truck)").document(truck.id).setData([
      "truck_id": truck.id,
      "driver_ci": truck.driverId,
      "assistant1_ci": truck.assistantsIds[0],
      "assistant2_ci": truck.assistantsIds[1],
      "companyBPS": truck.companyBPS.rawValue,
      "isFixed": truck.isFixed
    ])
    completion(true)
    print("Truck \(truck.id) was added successfully")
  }

  func getTrucksForToday(completion: @escaping ([TruckForTodayResponse]) -> Void) {
    let today = getTodaysDate()
    firestore.collection("\(K.Firebase.wages)/\(today)").getDocuments { doc, error in
      guard let documents = doc?.documents else { return }
      var trucks: [TruckForTodayResponse] = []
      documents.forEach { document in
        let data = document.data()
        let truckForToday = TruckForTodayResponse(id: document.documentID, dictionary: data)
        trucks.append(truckForToday)
      }
      completion(trucks)
    }
  }

  func trucksWereSelectedToday(completion: @escaping (Bool) -> Void) {
    let today = getTodaysDate()
    firestore.collection("\(K.Firebase.wages)/\(today)").getDocuments { doc, error in
      guard let doc else { return completion(false) }
      completion(!doc.documents.isEmpty)
    }
  }

  private func getTodaysDate() -> String {
    let todaysDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = K.Firebase.Formats.collectionDate
    return dateFormatter.string(from: todaysDate)
  }

}
