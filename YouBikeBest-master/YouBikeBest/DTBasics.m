//
//  DTBasics.m
//  DTBasicPool
//
//  Created by David Tseng on 2/6/13.
//  Copyright (c) 2013 David Tseng. All rights reserved.
//

#import "DTBasics.h"

@implementation DTBasics

+(NSString*)pathSimulatorDocuments{
    NSString* path = [[NSBundle mainBundle] bundlePath];
    return path;
}

+(void)logArrayContent:(NSArray*)array withName:(NSString*)name{
    
    if (name == nil) {
        name = [NSString stringWithFormat:@"Array"];
    }
    for (int i=0; i<[array count]; i++) {
        NSLog(@"%@[%i]:%@",name,i,[array objectAtIndex:i]);
    }
}

+(NSString*)deleteSpacesInString:(NSString*)input{
    NSString *stringWithoutSpaces = [input stringByReplacingOccurrencesOfString:@" " withString:@""];
    return stringWithoutSpaces;
}

+(NSString*)stringDateToday{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    dateFormatter.dateFormat=@"MMMM";
    NSString * monthString = [[dateFormatter stringFromDate:date] capitalizedString];
    NSLog(@"month: %@", monthString);
    dateFormatter.dateFormat=@"dd";
    NSString * dayString = [[dateFormatter stringFromDate:date] capitalizedString];
    NSLog(@"day: %@", dayString);
    NSString *dateString = [NSString stringWithFormat:@"%@ %@",monthString,dayString];
    return dateString;
}

+(BOOL)isOnlyNumeric:(NSString*)inputString{
    
    return [self isStringInSet:@"1234567890" ofInput:inputString];
}
+(BOOL)isOnlyAlphabet:(NSString*)inputString{
    
    return [self isStringInSet:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ" ofInput:inputString];
}
+(BOOL)isOnlyAlphabetAndNumeric:(NSString*)inputString{
    
    return [self isStringInSet:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789" ofInput:inputString];
}

+(BOOL)isContainsSubString:(NSString*)subString inInputString:(NSString*)inputString{
    
    if ([inputString rangeOfString:subString].location == NSNotFound) {
        //NSLog(@"string does not contain %@",subString);
        return FALSE;
    } else {
        //NSLog(@"string contains %@!",subString);
        return TRUE;
    }
}

+(BOOL)isStringInSet:(NSString*)stringSet ofInput:(NSString*)inputString{
    BOOL validate = FALSE;
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:stringSet] invertedSet];
    if ([inputString rangeOfCharacterFromSet:set].location != NSNotFound) {
        NSLog(@"This string contains illegal characters");
    }else{
        validate = TRUE;
    }
    return validate;
}


+(void)setViewSinkFromCenterPoint:(UIView*)view sinkInsideByPixel:(int)offset{
    
    CGRect rectangle = view.frame;
    CGPoint newOrigin = CGPointMake(rectangle.origin.x + offset, rectangle.origin.y + offset);
    CGSize newSize  = CGSizeMake(rectangle.size.width - 2*offset, rectangle.size.height - 2*offset);
    [view setFrame:CGRectMake(newOrigin.x, newOrigin.y, newSize.width, newSize.height)];
    
}

+(void)setViewAddLabelInCenter:(UIView*)view addLabel:(UILabel*)label{
    
    CGSize newSize  = CGSizeMake(view.frame.size.width, view.frame.size.height);
    [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, newSize.width, newSize.height)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:label];
}

+(void)sortArray:(NSMutableArray*)array{
    
    
}

@end




@implementation UILabel (dynamicSizeMeWidth)

-(void)resizeToVeryFit{
    float width = [self expectedWidth];
    CGRect newFrame = [self frame];
    newFrame.size.width = width;
    [self setFrame:newFrame];
}

-(float)expectedWidth{
    [self setNumberOfLines:0];
    CGSize maximumLabelSize = CGSizeMake(9999,self.frame.size.height);
    CGSize expectedLabelSize = [[self text] sizeWithFont:[self font]
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:[self lineBreakMode]];
    return expectedLabelSize.width;
}

@end


