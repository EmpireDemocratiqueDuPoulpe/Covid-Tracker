//
//  Home.swift
//  Covid Tracker
//
//  Created by Spoon Overlord on 08/03/2021.
//

import SwiftUI

// MARK: - Home
struct Home : View {
    @EnvironmentObject var api: CovidApi
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                StatBlock(
                    title: NSLocalizedString("Cases", comment: ""),
                    currentValue: api.apiResponse?.Global.getConfirmed(),
                    newValueFromToday: api.apiResponse?.Global.getNewConfirmed()
                )
                    
                StatBlock(
                    title: NSLocalizedString("Recovered", comment: ""),
                    currentValue: api.apiResponse?.Global.getRecovered(),
                    newValueFromToday: api.apiResponse?.Global.getNewRecovered(),
                    newValueColor: Color(UIColor.systemGreen)
                )
                    
                StatBlock(
                    title: NSLocalizedString("Deaths", comment: ""),
                    currentValue: api.apiResponse?.Global.getDeaths(),
                    newValueFromToday: api.apiResponse?.Global.getNewDeaths()
                )
                
                VStack {
                    if api.apiResponse != nil, let updateDate = api.apiResponse?.Global.getUpdateDate() {
                        HStack {
                            Spacer()
                            Text(String(format: NSLocalizedString("Last update: %@", comment: ""), updateDate))
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing)
                        }
                    }
                    
                    if api.usingLocalFile {
                        HStack {
                            Spacer()
                            Text(NSLocalizedString("Using local data", comment: ""))
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing)
                        }
                    }
                }
                
                Spacer()
            }
        }.navigationTitle(NSLocalizedString("Home", comment: ""))
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
                
                if self.newValueFromToday != nil && self.newValueFromToday! != 0 {
                    Text("+ \(self.newValueFromToday!)")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .foregroundColor(self.newValueColor)
                }
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
        
        StatBlock(title: NSLocalizedString("Cases", comment: ""), currentValue: 46587, newValueFromToday: 4123)
    }
}
