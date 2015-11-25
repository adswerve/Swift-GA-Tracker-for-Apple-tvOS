# Google Analytics tracker for Apple tvOS
by Analytics Pros
## About
Google Analytics tracker for Apple tvOS provides an easy integration of Google Analytics’ measurement protocol into Apple TV applications. Wrapper enables sending screenviews, events, exceptions and other hits to Google Analytics. Implementation of the library and sending an initial hit to Google Analytics takes only a few minutes.
Implementation
All the code for this tracker is located inside a single file “GATracker.swift”. First step of the implementation is associating the library file with your application project.

This specific library creates an object (a tracker) that holds persistent values such as client id, property id, version etc. Object is created with the following command:
GATracker.setup("UA-8705807-25")

## Hit Examples
Once the tracker is set up you can start sending Google Analytics hits from your Apple TV application.
### Screenview
When sending a screenview hit screenname is a required field.
GATracker.sharedInstance.screenView("FirstScreen", customParameters: nil)
### Event
When sending an event hit, event category and action a required fields
GATracker.sharedInstance.event("category", action: "action", label: nil, customParameters: nil)
### Exception
When sending an exception hit, exception description and exception “fatality” are two required parameters
GATracker.sharedInstance.expection("This test failed", isFatal: true, customParameters: nil)
### Sending Additional Parameters
With each hit you are also able to send additional parameters as specified in the Measurement Protocol reference such as “non interactive hit”, “event value”,  “custom dimensions”, “custom metrics” etc. 

In the following example we will add custom metric values and set an event hit as non interactive. The example shows how to send a video progress hit that includes video name as a custom dimension 1, video author as custom dimension 2 and sets the event as non interactive (since the event is not a result of user interaction).
GATracker.sharedInstance.event("Video", action: "Progress", label:"50%", customParameters: ["cd1":"Incredible Video", "cd2":"Amazing A. Uthor", "ni":1])

As mentioned before you are able to use any measurement protocol parameters inside the customParameters dictionary.
https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters?hl=en

### Sending Other Hit Types to Google Analytics
Screenview, event and exception are not the only hit types available in Google Analytics, to send a different hit such as a transaction, item, social or timing hit use send function.

In the following example we will send a transaction hit with transaction id 10001 and transaction revenue of $425,00.
GATracker.sharedInstance.send("transaction", params: ["tid":"10001", "tr":"425,00", "cu":"USD"])



