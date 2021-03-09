//
//  TabsView.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 09/03/2021.
//

import SwiftUI

// MARK: - TabsView
struct TabsView: View {
    var body: some View {
        TabView {
            NavigationView {
                Home()
            }.tabItem {
                Label("Accueil", systemImage: "house.fill")
            }
            
            NavigationView {
                CountriesList()
            }.tabItem {
                Label("Pays", systemImage: "mappin.and.ellipse")
            }
        }
    }
}

// MARK: - Preview
struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
            .environmentObject(CovidApi())
    }
}
