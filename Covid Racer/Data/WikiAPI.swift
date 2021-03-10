//
//  WikiAPI.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 10/03/2021.
//

import Foundation

class WikiAPI : ObservableObject {
    let language: String = "fr"
    let apiUrl = "https://%@.wikipedia.org/w/api.php?"
    let getPageExtract = "action=query&prop=extracts&exintro=1&explaintext=1&titles=%@&continue=&format=json&formatversion=2"
    
    @Published var searchedPage: WikiPage?
    
    // MARK: - HTTP queries
    func getPageExtract(pageName: String) {
        // Build service URL
        let url = String(format: self.apiUrl, self.language)
        let params = String(format: self.getPageExtract, pageName)
        
        guard let serviceUrl = URL(string: url + params)
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
                    let decodedJSON = try JSONDecoder().decode(WikiResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.searchedPage = decodedJSON.query?.getPage(withName: pageName)
                    }
                } catch {
                    self.showError(error)
                }
            }
        }.resume()
    }
    
    // MARK: - Others functions
    func showError(_ error: Error?) {
        if let err = error {
            print(err)
        }
    }
}
