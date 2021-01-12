//
//  RewardViewController.swift
//  RewardsApp
//
//  Created by flock on 07/01/21.
//

import UIKit

class RewardViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var eggContainerStackView: UIStackView!
    @IBOutlet weak var eggTopImageView: UIImageView!
    @IBOutlet weak var eggBottomImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var giftBoxView: UIView!
    @IBOutlet weak var giftBoxTopImageView: UIImageView!
    @IBOutlet weak var giftBoxBottomImageView: UIImageView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    var giftCardView: RewardView = RewardView()
    
    var rewardViewModel = RewardsViewModel()
    var showingReward: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.containerView.addBorder(width: 2)
        self.giftCardView.addBorder(width: 4, color: .purple)
        self.giftBoxView.addSubview(self.giftCardView)
        self.resetUI()
    }
    
    private func resetUI() {
        self.showingReward                      = false
        self.infoLabel.text                     = RewardsViewModel.Texts.shakeDevice
        self.infoLabel.isHidden                 = false
        self.eggTopImageView.frame.origin       = CGPoint(x: 0, y: 0)
        self.eggBottomImageView.frame.origin    = CGPoint(x: 0, y: 70)
        
        self.giftBoxView.transform              = CGAffineTransform(scaleX: 0, y: 0)
        self.giftBoxView.isHidden               = true
        self.giftBoxTopImageView.frame.origin.y = 0
        self.giftBoxTopImageView.isHidden       = false
        self.giftBoxBottomImageView.isHidden    = false
        
        self.giftCardView.frame                 = CGRect(origin: self.giftBoxBottomImageView.frame.origin, size: CGSize(width: 100, height: 50))
        self.giftCardView.center                = self.giftBoxBottomImageView.center
        self.giftCardView.transform             = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.giftCardView.isHidden              = true
        self.giftCardView.reset()
        self.giftBoxView.sendSubviewToBack(self.giftCardView)
        
        self.buttonsStackView.isHidden          = true
        
        self.view.layoutSubviews()
    }
    
    //MARK:- Shake Gesture
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            print("Shake Gesture Detected")
            if !showingReward {
                self.onShake()
            }
        }
    }
    
    private func onShake() {
        self.showingReward = true
        self.crackEggsAndShowGiftBox()
    }
    
    //MARK:- Button Actions
    @IBAction func tappedGiftBox(_ sender: Any) {
        self.openGiftBox()
    }
    @IBAction func tappedRedeemButton(_ sender: Any) {
        AlertUtils.showAlert(title: "Redeemed", message: "You have redeemed your reward", leftButtonTitle: "OK", leftButtonAction: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    
    //MARK:- Show Gift Box
    private func crackEggsAndShowGiftBox() {
        self.infoLabel.isHidden = true
        self.shakeEggs() {
            self.crackEggs {
                self.showGiftBox()
            }
        }
    }
    
    private func shakeEggs(completion: @escaping CompletionHandler) {
        self.eggContainerStackView.showShakeAnimation(completion: completion)
    }
    
    private func crackEggs(completion: @escaping CompletionHandler) {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) {
            self.eggTopImageView.frame          = CGRect(origin: CGPoint(x: 0, y: -20), size: self.eggTopImageView.frame.size)
            self.eggBottomImageView.frame       = CGRect(origin: CGPoint(x: 0, y: 90), size: self.eggBottomImageView.frame.size)
        } completion: { (_) in
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn) {
                self.eggTopImageView.frame.origin          = CGPoint(x: self.eggContainerStackView.frame.width + 10, y: -20)
                self.eggBottomImageView.frame.origin       = CGPoint(x: -self.eggContainerStackView.frame.width - 10, y: 90)
            } completion: { (_) in
                completion()
            }

        }
    }
    
    private func showGiftBox() {
        self.giftBoxView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn) {
            self.giftBoxView.transform = .identity
        } completion: { (_) in
            self.showInfoLabel(RewardsViewModel.Texts.openGift)
        }
    }
    
    //MARK:- Reveal Gift
    private func openGiftBox() {
        self.infoLabel.isHidden = true
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveLinear) {
            self.giftBoxTopImageView.frame.origin.y = -50
        } completion: { (_) in
            self.revealGift()
        }
        
    }
    
    private func revealGift() {
        UIView.animate(withDuration: 0.5) {
            self.giftCardView.isHidden          = false
            self.giftCardView.frame.origin.y    = 0
        } completion: { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.giftBoxView.bringSubviewToFront(self.giftCardView)
                UIView.transition(with: self.giftCardView, duration: 0.5, options: .transitionFlipFromRight) {
                    self.giftCardView.frame.origin.y = (self.giftBoxView.frame.height - self.giftCardView.frame.height)/2
                    self.giftCardView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    self.giftCardView.populateRewardView(with: self.rewardViewModel.returnRandomReward())
                } completion: { (_) in
                    self.giftBoxTopImageView.isHidden       = true
                    self.giftBoxBottomImageView.isHidden    = true
                    self.showInfoLabel(RewardsViewModel.Texts.congratulations)
                    self.buttonsStackView.isHidden  = false
                }
            }
        }
    }
    
    //MARK: Animate Info label
    private func showInfoLabel(_ text: String) {
        UIView.transition(with: self.infoLabel, duration: 1.0, options: .transitionCrossDissolve) {
            self.infoLabel.text     = text
            self.infoLabel.isHidden = false
        } completion: { (_) in
        }
    }
    

    
}

