//
//  Covid_TrackerApp.swift
//  Covid Tracker
//
//  Created by Spoon Overlord on 08/03/2021.
//

import SwiftUI

@main
struct Covid_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            TabsView()
                .environmentObject(CovidApi())
                .environmentObject(Favorites())
        }
    }
}
