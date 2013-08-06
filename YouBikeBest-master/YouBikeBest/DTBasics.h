//
//  DTBasics.h
//  DTBasicPool
//
//  Created by David Tseng on 2/6/13.
//  Copyright (c) 2013 David Tseng. All rights reserved.
//

#import <Foundation/Foundation.h>


//Defines

//Device OS
#define isIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]==4)
#define isIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]==5)
#define isIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]==6)
#define isAfterIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]>4)
#define isAfterIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]>5)
#define isAfterIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]>6)






@interface DTBasics : NSObject

//Path
+(NSString*)pathSimulatorDocuments;

//Log
+(void)logArrayContent:(NSArray*)array withName:(NSString*)name;

//String
+(NSString*)deleteSpacesInString:(NSString*)input;
+(NSString*)stringDateToday;
+(BOOL)isOnlyNumeric:(NSString*)inputString;
+(BOOL)isOnlyAlphabet:(NSString*)inputString;
+(BOOL)isOnlyAlphabetAndNumeric:(NSString*)inputString;
+(BOOL)isContainsSubString:(NSString*)subString inInputString:(NSString*)inputString;

//View
+(void)setViewSinkFromCenterPoint:(UIView*)view sinkInsideByPixel:(int)offset;
+(void)setViewAddLabelInCenter:(UIView*)view addLabel:(UILabel*)label;

//Array Sorting
+(void)sortArray:(NSMutableArray*)array;


@end



@interface UILabel (dynamicSizeMeWidth)

-(void)resizeToVeryFit;

@end

