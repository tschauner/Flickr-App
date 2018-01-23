//
//  RealmManager.swift
//  JodelChallenge
//
//  Created by Philipp Tschauner on 22.01.18.
//  Copyright © 2018 Jodel. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {
    }
    
    fileprivate var realm = try! Realm()
    
    /// Retrieves Realm object
    func retrieve<T: Object>(_ object: T) -> Results<T> {
        let results = realm.objects(T.self)
        return results
    }

    

    /// writes all objects to the realm database & updates all old
    ///
    /// - Parameters:
    ///   - object: generic
    ///   - complete: function
    func create<T: Object>(_ object: T, complete: @escaping () -> ()) {
        
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    self.realm.add(object, update: true)
                    complete()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    /// fetches all objes from the realm database
    ///
    /// - Parameter results: returns all objecs in an Array
    func fetchAll<T: Object>(results: @escaping (([T]) -> Void)) {
        
        DispatchQueue.main.async {
            
            let objs = self.realm.objects(T.self)
            let objArray =  Array(objs)
            results(objArray)
        }
    }
}
