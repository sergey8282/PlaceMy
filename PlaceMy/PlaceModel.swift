//
//  PlaceModel.swift
//  PlaceMy
//
//  Created by СОВА on 09.01.2021.
//

import RealmSwift


class Place: Object {
    
    // значения по умолчанию в классе 
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    
    // создаем конструктор для ввода данных
    convenience init(name: String, location: String?, type: String?, imageData: Data?){
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
}
