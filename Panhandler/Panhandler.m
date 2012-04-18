//
//  Panhandler.m
//  Panhandler
//
//  Created by Arthur Ariel Sabintsev at Shelby.tv on 4/15/12.
//  Copyright (c) 2012 ArtSabintsev. All rights reserved.
//

#import "Panhandler.h"

#pragma mark - Private Macros

// NSUserDefaults String Identifiers
#define PanhandlerPreviouslyLaunched            @"PreviouslyLaunched" 
#define PanhandlerTrackingDisabled              @"TrackingDisabled"
#define PanhandlerDidChooseRemindMeLater        @"DidChooseRemindMeLater"                                        
#define PanhandlerCounter                       @"Counter"                                                  
#define PanhandlerVersion                       @"Version"                                                  

// App Information
#define PanhandlerAppName                       [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey]              
#define PanhandlerAppVersion                    [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]           
#define PanhandlerAppStoreLink                  [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", PanhandlerAppleID]


#pragma mark - Private Declarations
@interface Panhandler () <UIAlertViewDelegate>

@property (assign, nonatomic)    BOOL        previouslyLaunched;        // Used to initialize default values on first launch
@property (assign, nonatomic)    BOOL        didChooseRemindMeLater;    // Flag used to remind user to rate app at a later time (when users selects 'Remind Me Later' in alertView)
@property (assign, nonatomic)    BOOL        trackingDisabled;          // Flag used to enable/disable tracking and alertView display (when user selects 'NO' in alertView)
@property (assign, nonatomic)    NSUInteger  counter;                   // Keeps track of number of events triggered
@property (copy, nonatomic)       NSString    *version;                 // Version of your app

- (void)defaultValues;                                                  // Set and/or reset default values
- (void)checkVersion;                                                   // Version Comparison method
- (void)checkNumberOfEventsTriggered:(NSUInteger)counter;               // Pop UIAlertView instance if certain conditions are satisfied
- (void)enableRemindMeLater;                                            // Enable 'Retrigger' state if 'Remind Me Later' is selected
- (void)disableTracking;                                                // Disable waseteful computation cycles if alert was displayed or 'NO' was selected
- (UIAlertView*)initializeAlertView;                                    // Create new instance of UIAlertView

@end

@implementation Panhandler

static Panhandler *sharedInstance = nil;

#pragma mark - Singleton Methods
+ (Panhandler*)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id)init
{
    
    if ( self = [super init] ) {
        
        // Set Default Variables
        if ( ![self previouslyLaunched] ) {
            
            // Set default values on first launch of application (after installation)
            [self defaultValues];
            
        }
        
    }
    
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - Public Methods
- (void)recordEvent
{
    // Check current version of app and perform reset if necessary
    [self checkVersion];
    
    // Increment Counter (saves to NSUserDefaults in custom setter)
    self.counter++;
}

- (void)recordEventWithWeight:(NSUInteger)weight
{
    // Check current version of app and perform reset if necessary
    [self checkVersion];
    
    // Increment Counter (saves to NSUserDefaults in custom setter)
    self.counter += weight;
}

#pragma mark - Private Methods
- (void)defaultValues
{
    self.previouslyLaunched = YES;
    self.didChooseRemindMeLater = NO;
    self.trackingDisabled = NO;
    self.counter = 0;
    self.version = PanhandlerAppVersion;
}

- (void)checkVersion
{
    if ( ![self.version isEqualToString:PanhandlerAppVersion] ) {       // If installed version doesn't match version saved in defaults (e.g., newer version installed)
        
        // Reset default values on version change
        [self defaultValues];
        
    }
}

- (void)checkNumberOfEventsTriggered:(NSUInteger)counter
{
    
    // Output current number of events triggered
    ( counter ) ? NSLog(@"[%@: %d Events Triggered]", NSStringFromClass([self class]), counter) : NSLog(@"[%@: Counter Reset]", NSStringFromClass([self class]));
    
    // Shows alert if conditions are satisfied    
    switch (PanhandlerDebugMode) {
            
        case NO:                                                        // If 'Debug Mode' is IS NOT enabled
            
            if ( ![self didChooseRemindMeLater] ) {                     // If 'Remind Me Later' IS NOT enabled
                
                if ( counter >= PanhandlerTrigger ) {    
                    
                    UIAlertView *alertView = [self initializeAlertView];
                    [alertView show];
                    
                }
                
            } else {                                                    // If 'Remind Me Later' IS enabled
                
                if ( counter >= PanhandlerRetrigger ) {
                    
                    UIAlertView *alertView = [self initializeAlertView];
                    [alertView show];
                    
                }
                
            } break;
            
        case YES:{                                                      // If 'Debug Mode' IS enabled
            
            UIAlertView *alertView = [self initializeAlertView];
            [alertView show];
            
        } break;
            
        default:
            break;
    }
}

- (void)disableTracking
{
    [self setTrackingDisabled:YES];
    [self setCounter:0];
}

- (void)enableRemindMeLater
{
    [self setDidChooseRemindMeLater:YES];
    [self setCounter:0];
}

- (UIAlertView*)initializeAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:PanhandlerAlertTitle 
                                                        message:PanhandlerAlertMessage 
                                                       delegate:self 
                                              cancelButtonTitle:PanhandlerNoMessage 
                                              otherButtonTitles:PanhandlerYesMessage, PanhandlerRemindMeLaterMessage, nil];
    
    return alertView;
}

#pragma mark - UIAlertViewDelegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:         // No
            
            [self disableTracking];
            break;
            
        case 1:{        // Yes
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PanhandlerAppStoreLink]];
            [self disableTracking];                                                                    
        }break;
        
        case 2:         // Remind Me Later
            
            [self enableRemindMeLater];
            break;
        
        default:
            break;
    }
    
}

#pragma mark - Accessor Methods that utilize NSUserDefaults
// previouslyLaunched
- (void)setPreviouslyLaunched:(BOOL)previouslyLaunched
{
    [[NSUserDefaults standardUserDefaults] setBool:previouslyLaunched forKey:PanhandlerPreviouslyLaunched];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)previouslyLaunched
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:PanhandlerPreviouslyLaunched];
}

// trackingDisabled
- (void)setTrackingDisabled:(BOOL)trackingDisabled
{
    [[NSUserDefaults standardUserDefaults] setBool:trackingDisabled forKey:PanhandlerTrackingDisabled];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)trackingDisabled
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:PanhandlerTrackingDisabled];
}

// didChooseRemindMeLater
- (void)setDidChooseRemindMeLater:(BOOL)didChooseRemindMeLater
{
    [[NSUserDefaults standardUserDefaults] setBool:didChooseRemindMeLater forKey:PanhandlerDidChooseRemindMeLater];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)didChooseRemindMeLater
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:PanhandlerDidChooseRemindMeLater];
}

// counter
- (void)setCounter:(NSUInteger)counter
{
    [[NSUserDefaults standardUserDefaults] setInteger:counter forKey:PanhandlerCounter];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    /*
     If user has not previously clicked 'No' on an alertView, 
     perform check on total number of events triggered, 
     and show alert if conditions within 'checkNumberOfEventsTriggered:' are satisfied.
     */
    
    if ( ![self trackingDisabled] ) [self checkNumberOfEventsTriggered:counter];
}

- (NSUInteger)counter
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:PanhandlerCounter];
}

// version
- (void)setVersion:(NSString *)version
{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:PanhandlerVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)version
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:PanhandlerVersion];
}

@end