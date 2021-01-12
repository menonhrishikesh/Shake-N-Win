//
//  RewardView.swift
//  RewardsApp
//
//  Created by flock on 08/01/21.
//

import UIKit

class RewardView: UIView {

    @IBOutlet weak var rewardIcon: UIImageView!
    @IBOutlet weak var rewardName: UILabel!
    
    var urlString: String?
    var view: UIView!
    
    func xibSetup() {
        view                    =   loadViewFromNib()
        view.frame              =   bounds
        view.autoresizingMask   =   [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        self.reset()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle  = Bundle(for: type(of: self))
        let nib     = UINib(nibName: "RewardView", bundle: bundle)
        let view    = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func reset() {
        rewardIcon.image    = nil
        rewardName.text     = ""
        urlString           = nil
    }
    
    func populateRewardView(with reward: Rewards?) {
        self.reset()
        self.urlString  = reward?.url
        self.populateUI(name: reward?.name, imageURLString: reward?.image)
    }
    
    private func populateUI(name: String?, imageURLString: String?) {
        self.rewardName.text    = name
        self.rewardIcon.loadImage(from: imageURLString, placeholderImage: UIImage(named: "gift_placeholder"), onSuccess: {}, onFailure: {})
    }
    
}
