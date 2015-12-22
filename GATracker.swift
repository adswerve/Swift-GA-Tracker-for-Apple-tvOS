//
//  AnalyticObject.swift
//  TVSwiftMeasurementProtocol
//
//  Created by Vincent Lee and Luka Cempre on 11/23/15.
//  Copyright © 2015 Analytics Pros. All rights reserved.
//

import Foundation

private var _analyticsTracker: GATracker!

class GATracker {
    /*
        Define properties
        @tid = Google Analytics property id
        @cid = Google Analytics client id
        @appName = Application Name 
        @appVersion = Application Version
        @MPVersion = Measurement Protocol version
        @ua = User Agent string
    */
    private var tid : String
    var cid: String
    var appName : String
    var appVersion : String
    var MPVersion : String
    var ua : String
    
    //Set up singleton object for the tracker
    class func setup(tid: String) -> GATracker {
        struct Static {
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken) {
            _analyticsTracker = GATracker(tid: tid)
        }
        return _analyticsTracker
    }
    
    class var sharedInstance: GATracker! {
        if _analyticsTracker == nil {
            #if DEBUG
                print("Analytics Tracker not set up")
            #endif
        }
        return _analyticsTracker
    }
    
    init(tid: String) {
        /*
            Initialize Tracker with Property Id
            Set up all attributes
        */
        #if DEBUG
            print("Google Analytics Tracker Initialized")
        #endif
        
        self.tid = tid
        self.appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
        let nsObject: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
        self.appVersion = nsObject as! String
        self.ua = "Mozilla/5.0 (Apple TV; CPU iPhone OS 9_0 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Mobile/13T534YI"
        self.MPVersion = "1"
        let defaults = NSUserDefaults.standardUserDefaults()
        if let cid = defaults.stringForKey("cid") {
            self.cid = cid
        }
        else {
            self.cid = NSUUID().UUIDString
            defaults.setObject(self.cid, forKey: "cid")
        }
    }
    
    func send(type: String, params: Dictionary<String, String>) {
        /*
            Generic hit sender to Measurement Protocol
            Consists out of hit type and a dictionary of other parameters
        */
        let endpoint = "https://www.google-analytics.com/collect?"
        var parameters = "v=" + self.MPVersion + "&an=" + self.appName + "&tid=" + self.tid + "&av=" + self.appVersion + "&cid=" + self.cid + "&t=" + type + "&ua=" + self.ua
        
        for (key, value) in params {
            parameters += "&" + key + "=" + value
        }
        
        //Encoding all the parameters
        if let paramEndcode = parameters.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet()){
            let urlString = endpoint + paramEndcode;
            let url = NSURL(string: urlString);
            
            #if DEBUG
                print(urlString)
            #endif
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
                if let httpReponse = response as? NSHTTPURLResponse {
                    let statusCode = httpReponse.statusCode
                    #if DEBUG
                        print(statusCode)
                    #endif
                }
                else {
                        if (error != nil) {
                            #if DEBUG
                                print(error!.description)
                            #endif
                        }
                }
            }
            task.resume()
        }
    }
    
    func screenView(screenName: String, customParameters: Dictionary<String, String>?) {
        /*
            A screenview hit, use screenname
        */
        var params = ["cd" : screenName]
        if (customParameters != nil) {
            for (key, value) in customParameters! {
                params.updateValue(value, forKey: key)
            }
        }
        self.send("screenview", params: params)
    }
    
    func event(category: String, action: String, var label: String?, customParameters: Dictionary<String, String>?) {
        /*
            An event hit with category, action, label
        */
        if label == nil {
            label = ""
        }
       
        //event parameters category, action and label
        var params = ["ec" : category, "ea" : action, "el" : label!]
        if (customParameters != nil) {
            for (key, value) in customParameters! {
                params.updateValue(value, forKey: key)
            }
        }
        self.send("event", params: params)
    }
    
    func exception(description: String, isFatal:Bool, customParameters: Dictionary<String, String>?) {
        /*
            An exception hit with exception description (exd) and "fatality"  (Crashed or not) (exf)
        */
        var fatal="0";
        if (isFatal){
            fatal = "1";
        }
        
        var params = ["exd":description, "exf":fatal]
        if (customParameters != nil) {
            for (key, value) in customParameters! {
                params.updateValue(value, forKey: key)
            }
        }
        self.send("exception", params: params)
        
    }
}