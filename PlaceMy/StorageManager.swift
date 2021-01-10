//
//  StorageManager.swift
//  PlaceMy
//
//  Created by СОВА on 10.01.2021.
//

import RealmSwift


let realm = try! Realm()


class StorageManager {
    
    //Метод добавления в базу данных
    static func saveObject(_ place: Place) {
        
        try! realm.write {
            realm.add(place)
        }
        
    }
    
    // Метод удаления с базы данных
    static func deleteObject(_ place: Place){
        
        try! realm.write {
            realm.delete(place)
        }
    }
}
