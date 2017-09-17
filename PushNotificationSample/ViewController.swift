//
//  ViewController.swift
//  PushNotificationSample
//
//  Created by Douglas Spencer on 9/7/17.
//  Copyright © 2017 Douglas Spencer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgMsgBubble: UIImageView!
    @IBOutlet weak var lblNotificationNumber: UILabel!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        StartListeningForBadgeUpdates()
        SetupBubbleImageTapGesture()
        UpdateBadgeLabel()
    }
    

    func StartListeningForBadgeUpdates() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.BadgeWasUpdated), name: NSNotification.Name(rawValue: "com.DouglasDevlops.BadgeWasUpdated"), object: nil)
    }
    
    func SetupBubbleImageTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.BubbleTapped))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        imgMsgBubble.isUserInteractionEnabled = true
        imgMsgBubble.addGestureRecognizer(tapGesture)
    }
    
    func UpdateBadgeLabel() {
        if UIApplication.shared.applicationIconBadgeNumber == 0 {
            lblNotificationNumber.isHidden = true
        } else {
            lblNotificationNumber.isHidden = false
            lblNotificationNumber.text = String(UIApplication.shared.applicationIconBadgeNumber)
        }
    }
    
    @objc func BadgeWasUpdated() {
        UpdateBadgeLabel()
    }
    
    @objc func BubbleTapped() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        lblNotificationNumber.isHidden = true
        lblNotificationNumber.text = ""
    }
}

