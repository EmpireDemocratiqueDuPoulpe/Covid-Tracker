//
//  CountriesList.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 09/03/2021.
//

import SwiftUI
import SwiftUIRefresh

// MARK: - CountriesList
struct CountriesList: View {
    @EnvironmentObject var api: CovidApi
    @EnvironmentObject var favorites: Favorites
    @State var showOnlyFavs = false
    @State(initialValue: "") var search: String
    @State var isRefreshing = false
    
    private var countries: [String : [Country]]? {
        return self.showOnlyFavs
            ? api.getOrderedCountriesWhere(idIsIn: self.favorites.getAll())
            : api.apiResponse?.OrderedCountries
    }
    
    var body: some View {
        VStack {
            SearchBar(content: $search)
            
            List {
                if self.countries != nil && (self.countries?.count ?? 0) > 0 {
                    
                    ForEach(api.groupNames, id: \.self) { groupName in
                        if let countriesOfGroup = self.countries![groupName]?.filter({ self.search.isEmpty ? true : $0.getNameAndCode().lowercased().contains(self.search.lowercased()) }), countriesOfGroup.count > 0 {
                            Section(header: Text(groupName)) {
                                ForEach(countriesOfGroup) { country in
                                    CountryRow(country: country)
                                }
                            }
                        }
                    }.onAppear() { self.isRefreshing = false }
                } else if self.isRefreshing {
                    Text("Chargement...")
                        .font(.subheadline)
                } else {
                    Text("Aucun pays trouvé.")
                        .font(.subheadline)
                }
            }.pullToRefresh(isShowing: self.$isRefreshing) {
                DispatchQueue.main.async {
                    self.api.getSummary()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                Text("Pays")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                Button(action: { self.showOnlyFavs.toggle() }) {
                    Image(systemName: (self.showOnlyFavs ? "star.fill" : "star"))
                }
            }
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
