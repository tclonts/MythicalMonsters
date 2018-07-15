//
//  City.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 7/13/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import Foundation

class City {
    
    private let nameKey = "city"
    private let lonKey = "lon"
    private let latKey = "lat"
    
    var name: String
    var lon: Double
    var lat: Double
    
    init(name: String, lon: Double, lat: Double) {
        self.name = name
        self.lon = lon
        self.lat = lat
    }
    
    init?(dictionary: [String : Any]) {
        guard let name = dictionary[nameKey] as? String,
            let lon = dictionary[lonKey] as? Double,
            let lat = dictionary[latKey] as? Double else { return nil }
        
        self.name = name
        self.lon = lon
        self.lat = lat
    }
    
}
