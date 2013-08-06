//
//  DTLocalNotification.h
//  NotificationTutorial
//
//  Created by David Tseng on 6/6/13.
//
//

#import <Foundation/Foundation.h>

@interface DTLocalNotification : NSObject

+ (void) createNotification:(NSString*)strTimeFormat withText:(NSString*)strShowText; //EnterDateFormate: mm-dd-yyyy HH:mm
+ (void) cancelAllNotifications;
+ (void) logAllNotifications;
+ (NSArray*) getAllNotifications; 


@end
