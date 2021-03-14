//
//  WikiModels.swift
//  Covid Tracker
//
//  Created by Spoon Overlord on 10/03/2021.
//

import Foundation
import SwiftUI

struct WikiResponse : Codable {
    var batchcomplete: Bool?
    var query: WikiQuery?
}

struct WikiQuery : Codable {
    var pages: [WikiPage]?
    
    func getPage(withName name: String) -> WikiPage? {
        return self.pages?.first(where: { $0.title == name })
    }
}

struct WikiPage : Codable {
    var pageid: Int?
    var ns: Int?
    var title: String?
    var extract: String?
    var missing: Bool?
    
    func getExtract() -> String? {
        return self.extract != nil ? self.extract! : (self.missing != nil && self.missing == true ? nil : nil)
    }
}
