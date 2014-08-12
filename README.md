# RateManager
Realizes the possibility to ask users to write a positive review of the application in appStore. individuality:
  - The class is designed as a Singleton
  - Allows you to flexibly adjust the time display pop-up message.

## Connection
In AppDelegate.m 
```objective-c
#import "RateManager.h"
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[RateManager sharedInstance] review];
}
``` 
Do not forget to ReviewManager.h add a direct link to the app in the App Store.

## Dependencies
No dependencies

