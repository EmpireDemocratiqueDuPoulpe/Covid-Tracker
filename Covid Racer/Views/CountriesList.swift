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
        List(api.apiResponse!.Countries) { country in
            CountryRow(country: country)
        }
        .navigationTitle("Pays")
    }
}

// MARK: - CountryRow
struct CountryRow: View {
    var country: Country
    
    var body: some View {
        NavigationLink(destination: CountryDetails(country: country)) {
            HStack {
                if let flag = country.getFlagImg() {
                    Image(uiImage: flag)
                }
                
                Text(country.getNameAndCode())
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
