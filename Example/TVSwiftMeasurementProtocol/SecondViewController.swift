//
//  SecondViewController.swift
//  TVSwiftMeasurementProtocol
//
//  Created by Vincent Lee on 11/24/15.
//  Copyright © 2015 Analytics Pros. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        GATracker.sharedInstance.screenView("SecondScreen", customParameters: ["cd1": "Seattle", "cm2": "2"])
    }

    @IBAction func exceptionFIred(sender: AnyObject) {
        print("Exception Fired")
        GATracker.sharedInstance.send("transaction", params: ["tid":"10001", "tr":"425,00", "cu":"USD"])
        GATracker.sharedInstance.exception("This test failed", isFatal: true, customParameters: nil)
    }

}
