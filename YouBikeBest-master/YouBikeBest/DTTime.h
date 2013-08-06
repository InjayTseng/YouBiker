//
//  DTTime.h
//  NotificationTutorial
//
//  Created by David Tseng on 6/6/13.
//
//

#import <Foundation/Foundation.h>

@interface DTTime : NSObject

+(NSArray*)createTimeAfterNowInEach:(int)minLength andNumberOfTimes:(int)numbers;
+(NSArray*)createTimeAfterNowInEach:(int)minLength andNumberOfTimes:(int)numbers andOffsetBy:(int)minOffset;

@end
