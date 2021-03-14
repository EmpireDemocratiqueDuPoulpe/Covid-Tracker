//
//  Favorites.swift
//  Covid Tracker
//
//  Created by Spoon Overlord on 10/03/2021.
//

import Foundation

class Favorites : ObservableObject {
    private var countriesKey = "countries_favs"
    private var countries: Set<String>
    
    init() {
        let decoder = JSONDecoder()
        
        if let favs = UserDefaults.standard.value(forKey: self.countriesKey) as? Data {
            let countriesFavs = try? decoder.decode(Set<String>.self, from: favs)
            self.countries = countriesFavs ?? []
        } else {
            self.countries = []
        }
    }
    
    // MARK: - ADD
    func add(_ country: Country) {
        objectWillChange.send()
        self.countries.insert(country.getId())
        self.save()
    }
    
    func toggle(_ country: Country) {
        if self.contains(country) {
            self.remove(country)
        } else {
            self.add(country)
        }
    }
    
    func save() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(self.countries) {
            UserDefaults.standard.set(encoded, forKey: self.countriesKey)
        }
    }
    
    // MARK: - GET
    func getAll() -> Set<String> {
        return self.countries
    }
    
    func contains(_ country: Country) -> Bool {
        return self.countries.contains(country.getId())
    }
    
    func isEmpty() -> Bool {
        return self.countries.isEmpty
    }
    
    // MARK: - DELETE
    func remove(_ country: Country) {
        objectWillChange.send()
        self.countries.remove(country.getId())
        self.save()
    }
    
    func cleanAll() {
        objectWillChange.send()
        self.countries = []
        self.save()
    }
}
