//
//  CovidAPI.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 09/03/2021.
//

import Foundation

class CovidApi : ObservableObject {
    let apiUrl = "https://api.covid19api.com"
    let apiSummaryPage = "/summary"
    
    @Published var apiResponse: CovidResponse?
    let groupNames: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    init() {
        getSummary()
    }
    
    // MARK: - HTTP queries
    func getSummary() {
        guard let serviceUrl = URL(string: apiUrl + apiSummaryPage)
        else { return }
        
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
                        self.apiResponse = decodedJSON
                        self.getOrderedCountries()
                    }
                } catch {
                    self.showError(error)
                }
            }
        }.resume()
    }
    
    // MARK: - Functions that return api response data
    func getConfirmed() -> Int { return apiResponse?.Global.TotalConfirmed ?? 0 }
    
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
    
    func showError(_ error: Error?) {
        if let err = error {
            print(err)
        }
    }
}
