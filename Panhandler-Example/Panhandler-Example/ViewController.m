//
//  ViewController.m
//  Panhandler-Example
//
//  Created by Arthur Ariel Sabintsev on 4/16/12.
//  Copyright (c) 2012 Arthur Ariel Sabintsev. All rights reserved.
//

#import "ViewController.h"
#import "Panhandler.h"

@implementation ViewController

#pragma mark - Action Methods
- (IBAction)buttonOne:(id)sender
{
    [[Panhandler sharedInstance] recordEvent];
}

- (IBAction)buttonTwo:(id)sender
{
    [[Panhandler sharedInstance] recordEventWithWeight:2];
}

- (IBAction)buttonThree:(id)sender
{
    [[Panhandler sharedInstance] recordEventWithWeight:3];
}

@end