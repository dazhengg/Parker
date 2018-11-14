# Parker
# Group Member
Lihang Pan, Haoran Zhang, Zekai Zhao, David Zheng

# General Design
![alt text][logo]
[logo]: https://github.com/ECS189E/Parker/blob/master/GeneralDesign.HEIC

# Current List of Third Party Library
SVProgressHUD 

# Server Support
Currently unclear, seems like we won't use server this time

# Models
TImer Model, Map Model, and camera

# ViewController 
> Main View Controller(VC1)
> > 1. VC1 to VC2 : An info button on the upper left corner of the screen
> > 2. VC1 to VC3: A setting button on the upper left corner of the screen
> > 3. VC1 to VC4: Swipe left
> > 4. VC1 to Camera: Swipe right

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

# Testing Plan
 The hard part for this App so far is the auto recognition of the location the user parked. If the user parked underground or parked in a parking structure, we need to recogize it and ask the user to enter the level they parked. We would like our users to test out this feature.
 
# Future Plan
1. Send Notification when no much time remaining
