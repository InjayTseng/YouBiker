//
//  DTLocalNotification.m
//  NotificationTutorial
//
//  Created by David Tseng on 6/6/13.
//
//

#import "DTLocalNotification.h"

@implementation DTLocalNotification

+ (void) createNotification:(NSString*)strTimeFormat withText:(NSString*)strShowText{
	NSLog(@"createNotification at %@",strTimeFormat);
	
	// get the date the user entered into the text field and save it iin a NSString
	NSString *dateString = strTimeFormat;
	// get the text the user entered into the text field and save it iin a NSString
	NSString *textString = strShowText;
	// create a NSDateFormatter that we will use to create a NSDate from the string
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
	[formatter setTimeZone:[NSTimeZone systemTimeZone]];
	// create a NSDate from the string using our formatter
	NSDate *alertTime = [formatter dateFromString:dateString];
	// get an instance of our UIApplication
	UIApplication* app = [UIApplication sharedApplication];
    // create the notification and then set it's parameters
	UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification)
    {
        notification.fireDate = alertTime;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.repeatInterval = 0;
		notification.alertBody = textString;
		// this will schedule the notification to fire at the fire date
		[app scheduleLocalNotification:notification];
		// this will fire the notification right away, it will still also fire at the date we set
		//[app presentLocalNotificationNow:notification];
    }
}

+ (void) cancelAllNotifications{

    NSLog(@"Cancel all Notifications");
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

+ (void) logAllNotifications{
    UIApplication *app = [UIApplication sharedApplication];
    for(UILocalNotification *loc in [app scheduledLocalNotifications]){
        NSLog(@"Notification will be triggered at %@",loc.fireDate);
    }
}

+ (NSArray*) getAllNotifications{
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *array = [[NSArray alloc]initWithArray:[app scheduledLocalNotifications]];
    return array;
}

@end
