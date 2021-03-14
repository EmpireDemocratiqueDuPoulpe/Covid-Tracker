//
//  CountryDetails.swift
//  Covid Tracker
//
//  Created by Spoon Overlord on 09/03/2021.
//

import SwiftUI

// MARK: - CountryDetails
struct CountryDetails : View {
    var country: Country
    @ObservedObject var wikiApi = WikiAPI()
    @EnvironmentObject var favorites: Favorites
    
    init(country: Country) {
        self.country = country
        self.wikiApi.getPageExtract(pageName: self.country.getName())
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 20.0) {
                ReadMoreText(self.wikiApi.searchedPage?.getExtract() ?? "", lineLimit: 3)
                    .font(.system(size: 16))
                    .padding([.top, .leading, .trailing])
                
                CountryStat(
                    title: "Nombre de cas",
                    currentValue: self.country.TotalConfirmed,
                    newValueFromToday: self.country.NewConfirmed
                )
                
                CountryStat(
                    title: "Nombre de soignés",
                    currentValue: self.country.TotalRecovered,
                    newValueFromToday: self.country.NewRecovered,
                    newValueColor: Color(UIColor.systemGreen)
                )
                
                CountryStat(
                    title: "Nombre de morts",
                    currentValue: self.country.TotalDeaths,
                    newValueFromToday: self.country.NewDeaths
                )
                
                if let updateDate = country.getUpdateDate() {
                    HStack {
                        Text("Dernière mise à jour: \(updateDate)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.trailing)
                            .padding(.leading, 30.0)
                        
                        Spacer()
                    }
                }
                
                Spacer()
            }
        }
        .padding(.all)
        
        // Custom toolbar
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(alignment: .center) {
                        Text(self.country.getName()).font(.headline)
                        
                        if let flag = self.country.getFlagImg() {
                            Image(uiImage: flag)
                                .resizable()
                                .frame(width: 32.0, height: 32.0)
                        }
                    }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    HStack(alignment: .center, spacing: 5.0) {
                        Button(action: {
                            ShareableStats(
                                subject: "Statistiques du COVID en \(self.country.getName())",
                                stats: self.country
                            ).share()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                        Button(action: {
                            self.favorites.toggle(self.country)
                        }) {
                            Image(systemName: (self.favorites.contains(self.country) ? "star.fill" : "star"))
                        }
                    }
                }
            }
    }
}

// MARK: - CountryStat
struct CountryStat : View {
    var title: String
    var currentValue: Int?
    var newValueFromToday: Int?
    var newValueColor: Color
    
    init(title: String, currentValue: Int?, newValueFromToday: Int?, newValueColor: Color = Color(UIColor.systemRed)) {
        self.title = title
        self.currentValue = currentValue
        self.newValueFromToday = newValueFromToday
        self.newValueColor = newValueColor
    }
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                // Title
                Text(self.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .padding(.bottom, 1.0)
                
                // Total value
                Text("Total: \(self.currentValue ?? 0)")
                    .padding(.leading)
                
                // Today value
                HStack {
                    Text("Depuis aujourd'hui: ")
                    
                    Text("\(self.newValueFromToday ?? 0)").foregroundColor(self.newValueColor)
                    
                    if self.newValueFromToday != nil && self.newValueFromToday! != 0 {
                        Image(systemName: "line.diagonal.arrow")
                            .foregroundColor(self.newValueColor)
                            .padding(.leading, -6.0)
                    }
                }
                .padding(.leading)
                
            }
            .padding(.leading)
            Spacer()
        }
    }
}

// MARK: - Preview
struct CountryDetails_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetails(
            country: Country(
                ID: "1",
                Country:"France",
                CountryCode:"Fr",
                Slug:"france",
                NewConfirmed:16746,
                TotalConfirmed:974356,
                NewDeaths:4734,
                TotalDeaths: 14688,
                NewRecovered:1,
                TotalRecovered:12,
                Date: "01/01/01"
            )
        ).environmentObject(Favorites())
    }
}
