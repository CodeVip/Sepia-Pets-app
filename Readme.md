# Author
Vipin Chaudhary
#Version
1.0

#Build and Runtime Requirements
Xcode 14.1 or later
iOS 16.1 or later

#Architectures 
Application created on the MVVM Architecture 

The Application used SwiftUI and Swift

On Pet details screen there is one warning for webview. I tried but 
it's seems it's apple side error and uses -

 dispatchqueue.global(qos .userinitiated)
 
 then it's show crash. i had limited time to figure out in details 

for example-
https://www.hackingwithswift.com/forums/swiftui/xcode-14-warning-this-method-should-not-be-called-on-the-main-thread-as-it-may-lead-to-ui-unresponsiveness/17431
