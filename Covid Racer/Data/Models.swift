//
//  Models.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 09/03/2021.
//

import Foundation

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

struct Country : Codable {
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
}
