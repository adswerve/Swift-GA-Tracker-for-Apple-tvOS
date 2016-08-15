//
//  SECONDViewController.m
//  TvOSGATrackerExampleInObjc
//
//  Created by Dennis on 15/8/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "SecondViewController.h"
#import "TvOSGATrackerExampleInObjc-Swift.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[GATracker sharedInstance] screenView:@"SecondScreen" customParameters:nil];
}

- (IBAction)exceptionFIred:(id)sender {
    NSLog(@"Exception Fired");
    [[GATracker sharedInstance] send:@"transaction" params:@{@"tid":@"10001", @"tr":@"425,00", @"cu":@"USD"}];
    [[GATracker sharedInstance] exception:@"This test failed" isFatal:YES customParameters:nil];
}
@end
