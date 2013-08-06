//
//  UBikeWebParser.h
//  YouBikeBest
//
//  Created by injay on 13/5/20.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CompletionBlock)(void);

@interface UBikeWebParser : NSObject

+(void)startParsing:(CompletionBlock)finishBlock;

@end
