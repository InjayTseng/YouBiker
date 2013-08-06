//
//  SocialSharing.h
//  SocialSharingSample
//
//  Created by David Tseng on 5/27/13.
//  Copyright (c) 2013 David Tseng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
@interface SocialSharing : NSObject

+(SLComposeViewController*)facebookSharing:(NSString*)text andImage:(UIImage*)image;
+(SLComposeViewController*)tweeterSharing:(NSString*)text andImage:(UIImage*)image;


@end
