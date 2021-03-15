//
//  SearchBar.swift
//  Covid Tracker
//
//  Created by Spoon Overlord on 13/03/2021.
//

import SwiftUI

struct SearchBar : View {
    @State private var isInUse = false
    @Binding var content: String
    
    var body: some View {
        let binding = Binding(
                    get: { self.content },
                    set: {
                        self.content = $0
                        self.isInUse = !self.content.isEmpty
                    }
                )
        
        HStack {
            // Search bar
            TextField(NSLocalizedString("Search...", comment: ""), text: binding)
                .padding(.vertical, 6.0)
                .padding(.horizontal, 25.0)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture { self.isInUse = true }
                
                .overlay(
                    HStack{
                        // Search icon
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(.systemGray))
                            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .padding(.leading, 13.0)
                        
                        // Cancel icon button
                        if self.isInUse {
                            Button(action: {
                                self.content = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color(.systemGray))
                                    .padding(.trailing, 13)
                            }
                        }
                    }
                )
            
            // Cancel button
            if self.isInUse {
                Button(action: {
                    self.content = ""
                    self.isInUse = false;
                }) {
                    Text(NSLocalizedString("Cancel", comment: ""))
                        .padding(.trailing)
                        .transition(.move(edge: .trailing))
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(content: .constant(""))
    }
}
