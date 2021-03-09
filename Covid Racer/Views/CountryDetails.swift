//
//  CountryDetails.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 09/03/2021.
//

import SwiftUI

// MARK: - CountryDetails
struct CountryDetails : View {
    var country: Country
    
    var body: some View {
        Text(country.getNameAndCode())
            
        // Custom toolbar
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text(country.getName()).font(.headline)
                        
                        if let flag = country.getFlagImg() {
                            Image(uiImage: flag)
                                .resizable()
                                .frame(width: 32.0, height: 32.0)
                        }
                    }
                }
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
        )
    }
}
