//
//  WebServiceOperation.h
//  YouBikeBest
//
//  Created by injay on 13/5/12.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NSDATA_BLOCK void (^)(NSData *imageData)
@interface WebServiceOperation : NSObject {
    
}

+ (void)processImageDataWithURLString:(NSString *)urlString andBlock:(NSDATA_BLOCK)processImage;
@end