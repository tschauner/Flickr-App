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

    
    /// creates and stores the Realm object
    func create<T: Object>(_ object: T, updateExisting: Bool = false, complete: @escaping () -> ()) {
        
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    self.realm.add(object, update: updateExisting)
                    complete()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// fetches all objects
    func fetchAll<T: Object>(results: @escaping (([T]) -> Void)) {
        
        DispatchQueue.main.async {
            
            let objs = self.realm.objects(T.self)
            let objArray =  Array(objs)
            results(objArray)
        }
    }
}
