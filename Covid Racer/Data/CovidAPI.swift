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
    func showError(_ error: Error?) {
        if let err = error {
            print(err)
        }
    }
}
