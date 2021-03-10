//
//  ReadMoreText.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 10/03/2021.
//

import SwiftUI

struct ReadMoreText : View {
    private var text: String
    let lineLimit: Int
    
    @State private var expanded = false
    @State private var shrinked = false
    
    init(_ text: String, lineLimit: Int = 2) {
        self.text = text
        self.lineLimit = lineLimit
    }
    
    private var readMoreText: String {
        return !self.shrinked ? "" : (self.expanded ? "Voir moins" : "Voir plus")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // This is the real displayed text
            Text(self.text)
                .lineLimit(self.expanded ? nil : self.lineLimit)
                .background(
                    // Two text are rendered here.
                    // This one is rendered with a lineLimit.
                    Text(self.text).lineLimit(self.lineLimit)
                        .background(GeometryReader { visibleGeo in
                            ZStack {
                                // This one is rendered without a lineLimit.
                                Text(self.text)
                                    .background(GeometryReader { fullGeo in
                                        // If the text without lineLimit is bigger than
                                        // the one with a line limit, the text is set
                                        // as "shrinked".
                                        Color.clear.onAppear {
                                            self.shrinked = fullGeo.size.height > visibleGeo.size.height
                                        }
                                    })
                            }.frame(height: .greatestFiniteMagnitude)
                        })
                        .hidden()
                )
            
            // Show a button used to expand/collapse the text.
            if self.shrinked {
                Button(action: {
                    withAnimation { self.expanded.toggle() }
                }, label: {
                    Text(self.readMoreText)
                })
            }
        }
    }
}

struct ReadMoreText_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading) {
        ReadMoreText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut laborum", lineLimit: 2)
    }.padding(.all)
  }
}
