//
//  ShareableStats.swift
//  Covid Racer
//
//  Created by Spoon Overlord on 11/03/2021.
//

import SwiftUI

class ShareableStats : NSObject, UIActivityItemSource {
    var subject: String = ""
    var stats: CovidStats
    
    init(subject: String, stats: CovidStats) {
        self.subject = subject
        self.stats = stats
    }
    
    // MARK: - Subject
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return self.subject
    }
    
    // MARK: - Content
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        if activityType == .postToTwitter {
            return "\(self.self.buildMessage())\n#CovidRacer"
        } else if activityType == .postToFacebook {
            return "\(self.buildMessage())\n#CovidRacer"
        } else {
            return self.buildMessage()
        }
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return self.buildMessage()
    }
    
    private func buildMessage() -> String {
        return "Nombre de cas: \(self.stats.getConfirmed()) (+\(self.stats.getNewConfirmed()))\n" +
            "Nombre de soignés: \(self.stats.getRecovered()) (+\(self.stats.getNewRecovered()))\n" +
            "Nombre de morts: \(self.stats.getDeaths()) (+\(self.stats.getNewDeaths()))"
    }
    
    // MARK: - Share
    func share() {
        let activity = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        //activity.popoverPresentationController?.sourceView = self.view
        activity.popoverPresentationController?.sourceView = UIApplication.shared.windows.first?.rootViewController?.view
        //activity.popoverPresentationController?.sourceView = navigationController?.navigationBar
        activity.isModalInPresentation = true
        
        UIApplication.shared.windows.first?.rootViewController?.present(activity, animated: true, completion: nil)
    }
}
