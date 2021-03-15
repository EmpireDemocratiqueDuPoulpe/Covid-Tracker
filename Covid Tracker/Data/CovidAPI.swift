//
//  CovidAPI.swift
//  Covid Tracker
//
//  Created by Spoon Overlord on 09/03/2021.
//

import Foundation

class CovidApi : ObservableObject {
    let apiUrl = "https://api.covid19api.com"
    let apiSummaryPage = "/summary"
    
    @Published var querySuccess: Bool = true
    @Published var usingLocalFile: Bool = false
    @Published var apiResponse: CovidResponse?
    let groupNames: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    init() {
        getSummary()
    }
    
    // MARK: - HTTP queries
    func getSummary() {
        guard let serviceUrl = URL(string: apiUrl + apiSummaryPage)
        else { return }
        
        self.apiResponse = nil
        self.querySuccess = true
        
        // Request build
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 20
        
        // Launch request
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decodedJSON = try JSONDecoder().decode(CovidResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.querySuccess = true
                        self.usingLocalFile = false
                        self.apiResponse = decodedJSON
                        self.getOrderedCountries()
                    }
                } catch {
                    self.showError(error)
                    self.getSummaryLocal()
                }
            }
        }.resume()
    }
    
    func getSummaryLocal() {
        if let path = Bundle.main.path(forResource: "last_data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decodedJSON = try JSONDecoder().decode(CovidResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.querySuccess = true
                    self.usingLocalFile = true
                    self.apiResponse = decodedJSON
                    self.getOrderedCountries()
                }
            } catch {
                self.querySuccess = false
                self.showError(error)
            }
        }
    }
    
    // MARK: - Others functions
    func getOrderedCountries() {
        var categories: [String: [Country]] = [:]
        
        for groupName in self.groupNames {
            if let countries = self.apiResponse?.getCountryStartingWith(groupName) {
                categories[groupName] = countries
            }
        }
        
        self.apiResponse?.OrderedCountries = categories
    }
    
    func getOrderedCountriesWhere(idIsIn idSet: Set<String>) -> [String: [Country]]? {
        var categories: [String: [Country]] = [:]
        
        for groupName in self.groupNames {
            if let countries = self.apiResponse?.getCountryStartingWith(groupName) {
                let filteredCountries = countries.filter({ idSet.contains($0.getId()) })
                
                if !filteredCountries.isEmpty {
                    categories[groupName] = filteredCountries
                }
            }
        }
        
        return categories
    }
    
    func showError(_ error: Error?) {
        if let err = error {
            print(err)
        }
    }
}
