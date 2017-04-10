//
//  ViewController.m
//  TvOSGATrackerExampleInObjc
//
//  Created by Dennis on 15/8/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "ViewController.h"
#import "TvOSGATrackerExampleInObjc-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[GATracker sharedInstance] screenView:@"FirstScreen" customParameters:nil];
}

- (IBAction)fireEvent:(id)sender{
    NSLog(@"Fire event");
    [[GATracker sharedInstance] event:@"a" action:@"b" label:nil customParameters:nil];
}

- (IBAction)nextScreenPressed:(id)sender{
    [self performSegueWithIdentifier:@"toSecondViewController" sender:nil];
}
@end
