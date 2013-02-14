# Panhandler

## Remind your active users to rate and review your iOS app

### About
**Panhandler** is an event-driven, ARC-complient singleton that reminds your users to rate and review your iOS app.

![Screenshot of Panhandler](https://github.com/ArtSabintsev/Panhandler/blob/master/screenshot.png?raw=true "Example Screenshot")

### Installation Instructions:

1. Copy the 'Panhandler' folder into your Xcode project. The following files will be added:
	1. Panhandler.h
	1. Panhandler.m
1. Follow the instructions below (also found in **Panhandler.h**):

<pre>

 - Add #import "Panhandler.h" to your class(es).
 
 - Configure the following macros in Panhandler.h:
 
                PanhandlerAppleID, 
                PanhandlerTrigger, 
                PanhandlerRetrigger, 
                PanhandlerDebugMode
                
 - Optionally, you may want to customize the following UIAlertView strings in Panhandler.h:
 
 				PanhandlerAlertTitle
 				PanhandlerAlertMessage
 				PanhandlerNoMessage
 				PanhandlerYesMessage
 				PanhandlerRemindMeLaterMessage
 
 - Record an event by adding one of the following messages to a signficant event:
 
 	// Event tracking method (adds +1 towards goals defined by trigger macros)
	[Panhandler sharedInstance] recordEvent]; 
 
 	// Weighted event tracking method (adds value of 'weight' towards goals defined by triggers)
    [Panhandler sharedInstance] recordEventWithWeight:(NSUInteger)weight]; 

 - Once your users has performed enough of these events (condition defined by triggers), a UIAlertView will pop up, asking your users to rate and review your app.

</pre>

The rest of the code is heavily commented, so customization/forking should be a snap!

### Inspired by:
- [Appirater](http://github.com/arashpayan/appirater/) 

###  Release Notes (v1.0.2):
- Changed to using CFBundleShortVersionString for version check

### Recognition:
- [iceberg901](http://github.com/iceberg901/) for the Panhandler name.
- Created for [Shelby.tv](http://www.shelby.tv) at Cyberdyne Systems NYC

Best,

[Arthur Ariel Sabintsev](http://www.sabintsev.com)  