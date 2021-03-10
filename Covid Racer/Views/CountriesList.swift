//
//  CountriesList.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 09/03/2021.
//

import SwiftUI

// MARK: - CountriesList
struct CountriesList: View {
    @EnvironmentObject var api: CovidApi
    
    var body: some View {
        if api.apiResponse?.Countries != nil {
            List {
                ForEach(api.groupNames, id: \.self) { groupName in
                    if let countries = api.apiResponse?.OrderedCountries[groupName] {
                        Section(header: Text(groupName)) {
                            ForEach(countries) { country in
                                CountryRow(country: country)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pays")
        }
    }
}

// MARK: - CountryRow
struct CountryRow: View {
    var country: Country
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        NavigationLink(destination: CountryDetails(country: country)) {
            HStack {
                if let flag = country.getFlagImg() {
                    Image(uiImage: flag)
                }
                
                Text(country.getNameAndCode())
                
                if self.favorites.contains(self.country) {
                    Spacer()
                    Image(systemName: "star.fill")
                        .padding(.trailing)
                }
            }
        }
    }
}

// MARK: - Preview
struct CountriesList_Previews: PreviewProvider {
    static var previews: some View {
        CountryRow(
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
        )
    }
}
