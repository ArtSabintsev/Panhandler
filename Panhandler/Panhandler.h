//
//  Panhandler.h
//  Panhandler
//
//  Created by Arthur at Shelby.tv on 4/15/12.
//  Copyright (c) 2012 ArtSabintsev. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 

 INSTRUCTIONS
 
 - Add #import "Panhandler.h" to your class(es).
 
 - Customize the following macros in Panhandler.h:
 
                PanhandlerAppleID, 
                PanhandlerTrigger, 
                PanhandlerRetrigger, 
                PanhandlerDebugMode
 
 - Record an event with the following code:
 
    [[Panhandler sharedInstance] recordEvent]

*/

#define PanhandlerAppleID       @"467849037"        // Apple ID for your app
#define PanhandlerTrigger       10                  // Number (integer) of events needed for ratings reminder alert
#define PanhandlerRetrigger     5                   // Number (integer) of events needed to retrigger ratings reminder alert 
#define PanhandlerDebugMode     NO                  // Set YES to show the alert every time. Set NO when shipping to App Store.

@interface Panhandler : NSObject

- (void)recordEvent;                                // Event tracking method
+ (Panhandler*)sharedInstance;                      // Singleton class method

@end