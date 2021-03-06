# Panhandler

## Remind your active users to rate your iOS app

### About
**Panhandler** is an event-driven, ARC-complient singleton that reminds your users to rate and review your iOS app.

###  Release Notes (v1.0.4):
- Addressed LLVM 5 issues

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

### Contirbutors:
- [iceberg901](http://github.com/iceberg901/) for the Panhandler name.

### Recognition

Created by [Arthur Ariel Sabintsev](http://www.sabintsev.com)  

### License
The MIT License (MIT)
Copyright (c) 2012-2013 Arthur Ariel Sabintsev

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.