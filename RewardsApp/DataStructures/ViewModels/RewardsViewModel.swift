//
//  RewardsViewModel.swift
//  RewardsApp
//
//  Created by flock on 08/01/21.
//

import UIKit

class RewardsViewModel: NSObject {

    var rewardsArray = [
        ["name": "Amazon Gift Card", "image": "https://img.favpng.com/14/25/2/amazon-com-gift-card-greeting-note-cards-product-return-png-favpng-NDNQ29DGbYXuuBZQQZLK2JXbY.jpg", "url": "https://www.amazon.in/Amazon-mail-Pay-Gift-Card/dp/B00KGE2ER2/ref=sr_1_11?dchild=1&keywords=rewards&qid=1610090696&sr=8-11"],
        ["name": "Writing Tablet", "image": "https://images-na.ssl-images-amazon.com/images/I/41pGgweNoPL.jpg", "url": "https://www.amazon.in/Fiddlys-Writing-Electronic-Handwriting-Assorted/dp/B0811MFDQQ/ref=sr_1_12?dchild=1&keywords=gifts&qid=1610090881&sr=8-12"],
        ["name": "Groot Toy", "image": "https://images-na.ssl-images-amazon.com/images/I/51x8vmLCr8L.jpg", "url": "https://www.amazon.in/Quace-Planter-Baby-Flowerpot-Container/dp/B07DNJPBVB/ref=sr_1_18?dchild=1&keywords=gifts&qid=1610090881&sr=8-18"],
        ["name": "Clock", "image": "https://images-na.ssl-images-amazon.com/images/I/617N95x-ZTL._SX522_.jpg", "url": "https://www.amazon.in/Sehaz-Artworks-Butterfly-Round-Clock/dp/B06XSBNXLT/ref=sr_1_23_sspa?dchild=1&keywords=gifts&qid=1610090881&sr=8-23-spons&psc=1&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUEzT1lPN1hKQUQ2VUlaJmVuY3J5cHRlZElkPUEwMzI0Njk0MTNFTE1aM0o5U1k2WCZlbmNyeXB0ZWRBZElkPUExMDI2MzY2TTFJQVJTNTJHWkcwJndpZGdldE5hbWU9c3BfbXRmJmFjdGlvbj1jbGlja1JlZGlyZWN0JmRvTm90TG9nQ2xpY2s9dHJ1ZQ=="],
        ["name": "Watch", "image": "https://images-na.ssl-images-amazon.com/images/I/81e5DKgUj7L._UL1500_.jpg", "url": "https://www.amazon.in/Emporio-Armani-Classic-Analog-Watch-AR2434/dp/B002LZUAFM/ref=sr_1_8?crid=7YI179M20NB7&dchild=1&keywords=watch+for+man&qid=1610091155&sprefix=watch%2Caps%2C312&sr=8-8"]
    ]
    
    struct Texts {
        static let shakeDevice      = "Shake the device to find your reward"
        static let openGift         = "Tap on the gift to reveal your reward"
        static let congratulations  = "Congratulations! You have won a reward"
    }
    
    var rewards = [Rewards]()
    
    override init() {
        super.init()
        self.setup()
    }
    
    private func setup() {
        self.rewards.removeAll()
        for arrayObj in rewardsArray {
            let reward = Rewards(dict: arrayObj)
            self.rewards.append(reward)
        }
    }
    
    func returnRandomReward() -> Rewards? {
        if let reward = self.rewards.randomElement() {
            return reward
        }
        return nil
    }
    
}
