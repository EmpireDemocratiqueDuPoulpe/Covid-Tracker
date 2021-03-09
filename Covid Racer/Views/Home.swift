//
//  Home.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 08/03/2021.
//

import SwiftUI

// MARK: - Home
struct Home : View {
    @EnvironmentObject var api: CovidApi
    
    var body: some View {
        VStack(alignment: .center) {
            StatBlock(
                title: "Nombre de cas",
                currentValue: api.apiResponse?.Global.TotalConfirmed,
                newValueFromToday: api.apiResponse?.Global.NewConfirmed
            )
                
            StatBlock(
                title: "Nombre de soignés",
                currentValue: api.apiResponse?.Global.TotalRecovered,
                newValueFromToday: api.apiResponse?.Global.NewRecovered,
                newValueColor: Color(UIColor.systemGreen)
            )
                
            StatBlock(
                title: "Nombre de morts",
                currentValue: api.apiResponse?.Global.TotalDeaths,
                newValueFromToday: api.apiResponse?.Global.NewDeaths
            )
            
            Spacer()
        }
        .navigationTitle("Accueil")
    }
}

// MARK: - StatBlock
struct StatBlock : View {
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
        VStack(alignment: .center) {
            Text(self.title)
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .padding(.bottom, -1.0)
            
            HStack {
                Text("\(self.currentValue ?? 0)")
                
                Text("+ \(self.newValueFromToday ?? 0)")
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(self.newValueColor)
            }
        }
        .padding(.all)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemGray5))
        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
        .padding(.horizontal)
    }
}

// MARK: - Preview
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(CovidApi())
        
        StatBlock(title: "Nombre de cas", currentValue: 46587, newValueFromToday: 4123)
    }
}