//
//  StorageManager.swift
//  PlaceMy
//
//  Created by СОВА on 10.01.2021.
//

import RealmSwift


let realm = try! Realm()


class StorageManager {
    
    static func saveObject(_ place: Place) {
        
        try! realm.write {
            realm.add(place)
        }
        
    }
    
}
