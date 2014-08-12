//
//  RateManager.h
//  Copyright (c) 2014 Mosdev LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REVIEW_APP_LINK @"LINK_APP" // like https://itunes.apple.com/ru/app/app/id483570037?mt=8
#define MESSAGE @"If you like our app, please rate it"
#define WAITDAYS  4 // Days to Start show
#define AFTERDAYS 1 // Days to remind again
#define OPENING   3 // After each open

@interface RateManager : NSObject

+(RateManager *) sharedInstance;
- (void)review;

@end
