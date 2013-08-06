//
//  DTTime.m
//  NotificationTutorial
//
//  Created by David Tseng on 6/6/13.
//
//

#import "DTTime.h"

@implementation DTTime

+(NSArray*)createTimeAfterNowInEach:(int)minLength andNumberOfTimes:(int)numbers{
    
    NSArray *array = [self createTimeAfterNowInEach:minLength andNumberOfTimes:numbers andOffsetBy:0];
    return array;
}

+(NSArray*)createTimeAfterNowInEach:(int)minLength andNumberOfTimes:(int)numbers andOffsetBy:(int)minOffset{

    //mm-dd-yyyy HH:mm
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    NSDate *now = [NSDate date]; // Grab current time
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    for (int i=1; i<=numbers; i++) {
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.minute = (i*minLength)+minOffset;
        NSDate *newDate = [theCalendar dateByAddingComponents:dayComponent toDate:now options:0];
        [tempArray addObject:newDate];
    }

    NSArray *array = [[NSArray alloc]initWithArray:tempArray];
    return array;
}




@end
