//
//  CovidModels.swift
//  Covid Tracker
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
    func ConvertDate() -> String
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
    func getUpdateDate() -> String      { return self.ConvertDate() }
    
    internal func ConvertDate() -> String {
        let inputDateFormat = DateFormatter()
        inputDateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let outputDateFormat = DateFormatter()
        outputDateFormat.dateFormat = "dd/MM/yyyy - HH:mm:ss"
        
        if let date = inputDateFormat.date(from: self.Date ?? "") {
            return outputDateFormat.string(from: date)
        } else {
            return ""
        }
    }
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
    func getName(localized: Bool = false) -> String {
        return (localized ? NSLocalizedString(self.getCode().uppercased(), comment: "") : (self.Country ?? ""))
    }
    func getCode() -> String            { return self.CountryCode ?? "" }
    func getFormattedCode() -> String   { return (self.CountryCode != nil ? "(\(self.CountryCode!))" : "") }
    func getNameAndCode(localized: Bool = false) -> String {
        return "\(self.getName(localized: localized)) \(self.getFormattedCode())"
    }
    func getSlug() -> String            { return self.Slug ?? "" }
    func getNewConfirmed() -> Int       { return self.NewConfirmed ?? 0 }
    func getConfirmed() -> Int          { return self.TotalConfirmed ?? 0 }
    func getNewDeaths() -> Int          { return self.NewDeaths ?? 0 }
    func getDeaths() -> Int             { return self.TotalDeaths ?? 0 }
    func getNewRecovered() -> Int       { return self.NewRecovered ?? 0 }
    func getRecovered() -> Int          { return self.TotalRecovered ?? 0 }
    func getUpdateDate() -> String      { return self.ConvertDate() }
    
    internal func ConvertDate() -> String {
        let inputDateFormat = DateFormatter()
        inputDateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let outputDateFormat = DateFormatter()
        outputDateFormat.dateFormat = "dd/MM/yyyy - HH:mm:ss"
        
        if let date = inputDateFormat.date(from: self.Date ?? "") {
            return outputDateFormat.string(from: date)
        } else {
            return ""
        }
    }
    
    func getFlagImg() -> UIImage? {
        return self.CountryCode != nil
            ? UIImage(named: self.CountryCode!.uppercased())
            : nil
    }
}

//extension Country : Identifiable {
//    var id: String { return ID }
//}
