# Panhandler

## Remind your active users to rate and review your iOS app

### About
**Panhandler** is an event-driven, ARC-complient singleton that reminds your users to rate and review your iOS app.

### Installation Instructions:

1. Copy the 'Panhandler' folder into your Xcode project. The following files will be added:
	1. Panhandler.h
	1. Panhandler.m
1. Follow the instructions below (also found in **Panhandler.h**):

<pre>

 - Add #import "Panhandler.h" to your class(es).
 
 - Customize the following macros in Panhandler.h:
 
                PanhandlerAppleID, 
                PanhandlerTrigger, 
                PanhandlerRetrigger, 
                PanhandlerDebugMode
 
 - Record an event by adding the following code to signficant event:
 
    [[Panhandler sharedInstance] recordEvent]

 - Once your users has performed enough of these events (condition defined by PanhandlerTrigger or PanhandlerRetrigger)

</pre>


### Inspired by:
- [Appirater](http://github.com/arashpayan/appirater/) 

###  Release Notes (v1.0.0):
- Initial Release

Best,

[Arthur Ariel Sabintsev](http://www.sabintsev.com)  