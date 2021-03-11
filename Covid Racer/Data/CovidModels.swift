//
//  CovidModels.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 09/03/2021.
//

import Foundation
import SwiftUI

protocol CovidStats {

    var NewConfirmed: Int? { get set }
    var TotalConfirmed: Int? { get set }
    var NewDeaths: Int? { get set }
    var TotalDeaths: Int? { get set }
    var NewRecovered: Int? { get set }
    var TotalRecovered: Int? { get set }
    var Date: String? { get set }
    
    func getNewConfirmed() -> Int
    func getConfirmed() -> Int
    func getNewDeaths() -> Int
    func getDeaths() -> Int
    func getNewRecovered() -> Int
    func getRecovered() -> Int
    func getUpdateDate() -> String
}

struct CovidResponse : Codable {
    var ID: String?
    var Message: String?
    var Global: GlobalStats = GlobalStats()
    var Countries: [Country] = []
    var OrderedCountries: [String: [Country]] = [:]
    
    private enum CodingKeys : String, CodingKey {
        case ID, Message, Global, Countries
    }
    
    func getCountryStartingWith(_ letter: String) -> [Country] {
        let lowerLetter = letter.lowercased()
        return self.Countries.filter({$0.Country?.first?.lowercased() == lowerLetter})
    }
}

struct GlobalStats : Codable, CovidStats {
    var NewConfirmed: Int?
    var TotalConfirmed: Int?
    var NewDeaths: Int?
    var TotalDeaths: Int?
    var NewRecovered: Int?
    var TotalRecovered: Int?
    var Date: String?
    
    func getNewConfirmed() -> Int       { return self.NewConfirmed ?? 0 }
    func getConfirmed() -> Int          { return self.TotalConfirmed ?? 0 }
    func getNewDeaths() -> Int          { return self.NewDeaths ?? 0 }
    func getDeaths() -> Int             { return self.TotalDeaths ?? 0 }
    func getNewRecovered() -> Int       { return self.NewRecovered ?? 0 }
    func getRecovered() -> Int          { return self.TotalRecovered ?? 0 }
    func getUpdateDate() -> String      { return self.Date ?? "" }
}

struct Country : Codable, Identifiable, CovidStats {
    // To be Identifiable, Country required an "id". "ID" doesn't match case
    // so this variable redirect every get/set to the real ID.
    var id: String {
        get { return self.ID ?? "" }
        set { self.ID = newValue }
    }
    
    var ID: String?
    var Country: String?
    var CountryCode: String?
    var Slug: String?
    var NewConfirmed: Int?
    var TotalConfirmed: Int?
    var NewDeaths: Int?
    var TotalDeaths: Int?
    var NewRecovered: Int?
    var TotalRecovered: Int?
    var Date: String?
    
    // Getters
    func getId() -> String              { return self.ID ?? "" }
    func getName() -> String            { return self.Country ?? "" }
    func getCode() -> String            { return self.CountryCode ?? "" }
    func getFormattedCode() -> String   { return (self.CountryCode != nil ? "(\(self.CountryCode!))" : "") }
    func getNameAndCode() -> String     { return "\(self.getName()) \(self.getFormattedCode())"}
    func getSlug() -> String            { return self.Slug ?? "" }
    func getNewConfirmed() -> Int       { return self.NewConfirmed ?? 0 }
    func getConfirmed() -> Int          { return self.TotalConfirmed ?? 0 }
    func getNewDeaths() -> Int          { return self.NewDeaths ?? 0 }
    func getDeaths() -> Int             { return self.TotalDeaths ?? 0 }
    func getNewRecovered() -> Int       { return self.NewRecovered ?? 0 }
    func getRecovered() -> Int          { return self.TotalRecovered ?? 0 }
    func getUpdateDate() -> String      { return self.Date ?? "" }
    
    func getFlagImg() -> UIImage? {
        return self.CountryCode != nil
            ? UIImage(named: self.CountryCode!.uppercased())
            : nil
    }
}

//extension Country : Identifiable {
//    var id: String { return ID }
//}
