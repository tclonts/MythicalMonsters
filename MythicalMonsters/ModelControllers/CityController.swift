//
//  CityController.swift
//  MythicalMonsters
//
//  Created by Tyler Clonts on 7/13/18.
//  Copyright © 2018 Tyler Clonts. All rights reserved.
//

import Foundation

class CityController {
    
    static let shared = CityController()
    
    var cities = [City]()
    
    func fetchCities() {
        guard let citiesJsonUrl = Bundle.main.url(forResource: "CitiesJSON", withExtension: "json") else {
            fatalError("file was moved \(#file)")
        }
        var temCityHolder: [City] = []
        guard let data = try? Data(contentsOf: citiesJsonUrl),
            let cityDictionary = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String : Any],
            let resultsDictionary = cityDictionary["results"] as? [[String : Any]] else { return }
        for result in resultsDictionary {
            guard let city = City(dictionary: result) else { continue }
            temCityHolder.append(city)
        }
        self.cities = temCityHolder
        //        print(cities)
    }
    
    @discardableResult func fetchCitiesWithSearchTerm(string: String) -> [City] {
        let filteredCities = cities.filter{$0.name.lowercased().contains(string.lowercased())}
        self.cities = filteredCities
        return filteredCities
    }
    
}
