//
//  Models.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 09/03/2021.
//

import Foundation
import SwiftUI

struct CovidResponse : Codable {
    var ID: String?
    var Message: String?
    var Global: GlobalStats = GlobalStats()
    var Countries: [Country] = []
}

struct GlobalStats : Codable {
    var NewConfirmed: Int?
    var TotalConfirmed: Int?
    var NewDeaths: Int?
    var TotalDeaths: Int?
    var NewRecovered: Int?
    var TotalRecovered: Int?
    var Date: String?
}

struct Country : Codable, Identifiable {
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
    
    func getFlagEmoji() -> String {
        if (self.CountryCode == nil) { return "" };
        
        return self.CountryCode!
            .uppercased()
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
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
