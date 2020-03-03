//
//  StorageManager.swift
//  carsApp
//
//  Created by Slava Kuzmitsky on 25.02.2020.
//  Copyright © 2020 Slava Kuzmitsky. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ car: Car) {
        
        try! realm.write {
            realm.add(car)
        }
    }
    
    static func deleteObject(_ car: Car) {
        try! realm.write {
         realm.delete(car)
        }
    }
}
