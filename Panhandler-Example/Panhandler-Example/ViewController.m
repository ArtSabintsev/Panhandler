//
//  ViewController.m
//  Panhandler-Example
//
//  Created by Arthur on 4/16/12.
//  Copyright (c) 2012 ArtSabintsev. All rights reserved.
//

#import "ViewController.h"
#import "Panhandler.h"

@implementation ViewController

#pragma mark - View Lifecycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

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


#pragma mark - Interface orientation methods
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end