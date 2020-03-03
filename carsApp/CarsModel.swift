//
//  CarsModel.swift
//  carsApp
//
//  Created by Slava Kuzmitsky on 25.02.2020.
//  Copyright © 2020 Slava Kuzmitsky. All rights reserved.
//

import RealmSwift

class Car: Object {
    
    @objc dynamic var brand = ""
    @objc dynamic var model = ""
    @objc dynamic var year = 0
    @objc dynamic var price = 0
    @objc dynamic var imageData: Data?
    @objc dynamic var raiting = 0.0
    
    convenience init(brand: String, model: String, year: Int, price: Int, imageData: Data?, raiting: Double?) {
        self.init()
        self.brand = brand
        self.model = model
        self.year = year
        self.price = price
        self.imageData = imageData
        self.raiting = raiting!
    }
}
