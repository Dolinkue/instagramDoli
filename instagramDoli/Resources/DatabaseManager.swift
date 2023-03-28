//
//  DatabaseManager.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 26/03/2023.
//

import Foundation
import FirebaseDatabase


public class DatabaseManager {
    
    private let database = Database.database().reference()
    
    static let shared = DatabaseManager()
    
    // MARK: - Public
    
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        completion(true)
        
    }
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                // success
                completion(true)
                
            }
            else {
                // failed
                completion(false)
                return
            }
        }
    }
}
