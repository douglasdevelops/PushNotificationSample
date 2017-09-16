//
//  ViewController.swift
//  PushNotificationSample
//
//  Created by Douglas Spencer on 9/7/17.
//  Copyright © 2017 Douglas Spencer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IbOutlets
    @IBOutlet weak var lblNotificationNumber: UILabel!
    @IBOutlet weak var imgBubble: UIImageView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        StartListeningForBadgeUpdates()
        SetupBubbleImageTapGesture()
        UpdateBadgeLabel()
        
    }
    
    //MARK: - User Functions
    func StartListeningForBadgeUpdates() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.BadgeWasUpdated), name: NSNotification.Name(rawValue: "com.DouglasDevelops.BadgeNumberUpdated"), object: nil)
    }
    
    func UpdateBadgeLabel() {
        if UIApplication.shared.applicationIconBadgeNumber == 0 {
            lblNotificationNumber.isHidden = true
        } else {
            lblNotificationNumber.text =  String(UIApplication.shared.applicationIconBadgeNumber)
        }
    }
    
    func SetupBubbleImageTapGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BubbleTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imgBubble.isUserInteractionEnabled = true
        imgBubble.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Notification Observers
    @objc func BadgeWasUpdated() {
        lblNotificationNumber.isHidden = false
        lblNotificationNumber.text =  String(UIApplication.shared.applicationIconBadgeNumber)
    }
    
    //MARK: - Gesture Recognizer Targets
    @objc func BubbleTapped() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        lblNotificationNumber.text = ""
        lblNotificationNumber.isHidden = true
    }
}

