//
//  RateManager.m
//  Copyright (c) 2014 Mosdev LLC. All rights reserved.
//

#import "RateManager.h"

@implementation RateManager
{
    NSUserDefaults* preferences;
}

static RateManager * sharedSingleton= nil;

+(RateManager *) sharedInstance
{
    
    static dispatch_once_t once_token = 0;
    dispatch_once(&once_token, ^
                  {
                      sharedSingleton =  [RateManager new];
                  });
    return sharedSingleton ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)review
{
    preferences = [NSUserDefaults standardUserDefaults];
    BOOL status = [self getDoubleForKey:@"ReviewManagerStatus" default:1];
    double FirstStart = [self getDoubleForKey:@"ReviewManagerFirstStart" default:[[NSDate date] timeIntervalSince1970]];
    [preferences setDouble:FirstStart forKey:@"ReviewManagerFirstStart"];
    NSInteger countLoad = [self getDoubleForKey:@"ReviewManagerCoundLoad" default:0];
    double lastNotification = [self getDoubleForKey:@"ReviewManagerLastNotification" default:0];
    double currentTime = [[NSDate date] timeIntervalSince1970];
    
    if (status)
    {
        if (currentTime - FirstStart > 86400*WAITDAYS)
        {
            countLoad = countLoad + 1;
            [preferences setDouble:countLoad forKey:@"ReviewManagerCoundLoad"];
            if ( currentTime - lastNotification > 86400*AFTERDAYS && countLoad > OPENING )
            {
                [preferences setDouble:0 forKey:@"ReviewManagerCoundLoad"];
                [preferences setDouble:currentTime forKey:@"ReviewManagerLastNotification"];
                [self showAlert];
            }
        }
    }
}

- (void)showAlert
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:nil
                                                              message:MESSAGE
                                                             delegate:self
                                                    cancelButtonTitle:@"Remind me later"
                                                    otherButtonTitles:@"No, thank you", @"Rate", nil];
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 1:
            [preferences setDouble:0 forKey:@"ReviewManagerStatus"];
            break;
        
        case 2:
            [preferences setDouble:0 forKey:@"ReviewManagerStatus"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:REVIEW_APP_LINK]];
            break;
            
        default:
            break;
    }
}

- (BOOL)senDoubleForKey:(double)value key:(NSString*)key
{
    [preferences setDouble:value forKey:key];
    return [preferences synchronize];
}

- (double)getDoubleForKey:(NSString*)key default:(double)def
{
    if([preferences objectForKey:key] == nil)
        return def;
    else
        return [preferences doubleForKey:key];
}

@end
