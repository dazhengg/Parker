# Parker
# Disclaimer 
Note that with Xcode, you must set the deveoper account and a unique bundle ID. Also, in order to install Parker correctly the Podfile must be installed along with Firebase. 
if the following pods in the podfile have not been installed 
1. pod install (If Firebase has never been used before, configure as follows https://firebase.google.com/docs/ios/setup)
ELSE do 2. and 3. In the event that there is a Firebase error the GoogleMaps must be downgraded to 5.20 (if GoogleMaps have been used with the computer before). Note that this is not a code error but a Firebase and Googlemap error. Users have also found success using an older version of Firebase i.e 1.0 version down. 
 1. pod update 
 2. pod install 
 
 


# Group Member
Lihang Pan, Haoran Zhang, Zekai Zhao, David Zheng

# General Design
Please see the GeneralDesign.HEIC under the root directory

# Current List of Third Party Library
SVProgressHUD, Firebase, JQSMessaging  

# Server Support
Firebase used to provide realtime database storage and synchornization. 

# Models
Timer Model, Map Model, and camera

# Trello Board
Trello board is set up.

# ViewController 
> Main View Controller(VC1)
> > 1. VC1 to VC2 : An info button on the upper middle corner of the screen
> > 2. VC1 to VC3: A setting button on the upper right corner of the screen
> > 3. VC1 to VC4: Swipe left
> > 4. VC1 to Camera: Swipe right
> > 5. VC1 to ChatVC: Chat capability (along with real time database storage) 

> Info View Controller(VC2)
> > 1. VC2 to VC1 : Back Button on the Navigation Bar

> Setting View Controller(VC3)
> > 1. VC3 to VC1: Back Button on the Navigation Bar

>  Timer View Controller(VC4)
> > 1. VC4 to VC1: Swipe Right
> > 2. VC4 to VC5: Swipe Left

> Count Down Timer View Controller(VC5)
> > 1. VC5 to VC4: Swipe Right

# Weekly Plan
Week1: VC1, Camera  
Week2: VC2 and VC3  
Week3: VC4 and VC5  
Final: ChatVC/ Firebase Storage

# Testing Plan
 The hard part for this App so far is the auto recognition of the location the user parked. If the user parked underground or parked in a parking structure, we need to recogize it and ask the user to enter the level they parked. We would like our users to test out this feature.
 
# Future Plan
1. Send Notification when no much time remaining (COMPLETE) 
2. Chat room for user interaction of leavers and parkers. In addition we added a real time update of messages being sent. (COMPLETE) 
