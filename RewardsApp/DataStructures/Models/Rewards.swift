//
//  Rewards.swift
//  RewardsApp
//
//  Created by flock on 08/01/21.
//

import UIKit

class Rewards: NSObject {

    var name: String?
    var image: String?
    var url: String?
    
    init(dict: [String: Any]) {
        super.init()
        self.populateRewards(from: dict)
    }
    
    private func populateRewards(from dict: [String: Any]) {
        if let value = dict["name"] as? String {
            self.name   = value
        }
        if let value = dict["image"] as? String {
            self.image  = value
        }
        if let value = dict["url"] as? String {
            self.url    = value
        }
    }
    
}
