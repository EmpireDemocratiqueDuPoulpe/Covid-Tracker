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
        Text("List")
    }
}

// MARK: - Preview
struct CountriesList_Previews: PreviewProvider {
    static var previews: some View {
        CountriesList()
    }
}
