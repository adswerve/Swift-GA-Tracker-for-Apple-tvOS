//
//  ViewController.swift
//  TVSwiftMeasurementProtocol
//
//  Created by Vincent Lee on 11/23/15.
//  Copyright © 2015 Analytics Pros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        GATracker.sharedInstance.screenView("FirstScreen", customParameters: nil)
    }
    
    @IBAction func fireEvent(sender: AnyObject) {
        print("Fire Event")
        GATracker.sharedInstance.event("a", action: "b", label: nil, customParameters: nil)
    }

    @IBAction func nextScreenPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("toSecondViewController", sender: nil)
    }
}

