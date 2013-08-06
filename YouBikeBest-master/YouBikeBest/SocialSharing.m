//
//  SocialSharing.m
//  SocialSharingSample
//
//  Created by David Tseng on 5/27/13.
//  Copyright (c) 2013 David Tseng. All rights reserved.
//

#import "SocialSharing.h"
#import <Social/Social.h>
@implementation SocialSharing

+(SLComposeViewController*)facebookSharing:(NSString*)text andImage:(UIImage*)image{

    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:text];
        [controller addURL:[NSURL URLWithString:@"http://4tyone.blogspot.tw/search/label/YouBike"]];
        [controller addImage:image];
        return controller;
    }
    return nil;
}

+(SLComposeViewController*)tweeterSharing:(NSString*)text andImage:(UIImage*)image{

    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:text];
        [tweetSheet addURL:[NSURL URLWithString:@"http://4tyone.blogspot.tw/search/label/YouBike"]];
        [tweetSheet addImage:image];
        return tweetSheet;
    }
    return nil;
}



@end
