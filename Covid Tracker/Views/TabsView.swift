//
//  TabsView.swift
//  Covid Tracker
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
                Label(NSLocalizedString("Home", comment: ""), systemImage: "house.fill")
            }
            
            NavigationView {
                CountriesList()
            }.tabItem {
                Label(NSLocalizedString("Country", comment: ""), systemImage: "mappin.and.ellipse")
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
