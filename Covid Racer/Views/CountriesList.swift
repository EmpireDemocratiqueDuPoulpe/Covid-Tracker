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
    @EnvironmentObject var favorites: Favorites
    @State var showOnlyFavs = false
    
    private var countries: [String : [Country]]? {
        return self.showOnlyFavs
            ? api.getOrderedCountriesWhere(idIsIn: self.favorites.getAll())
            : api.apiResponse?.OrderedCountries
    }
    
    var body: some View {
        if self.countries != nil {
            List {
                ForEach(api.groupNames, id: \.self) { groupName in
                    if let countriesOfGroup = self.countries![groupName], countriesOfGroup.count > 0 {
                        Section(header: Text(groupName)) {
                            ForEach(countriesOfGroup) { country in
                                CountryRow(country: country)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pays")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button(action: { self.showOnlyFavs.toggle() }) {
                        Image(systemName: (self.showOnlyFavs ? "star.fill" : "star"))
                    }
                }
            }
        } else {
            Text("Aucun pays trouvé.")
                .font(.subheadline)
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
        CountriesList().environmentObject(CovidApi())
            
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
        ).environmentObject(Favorites())
    }
}
