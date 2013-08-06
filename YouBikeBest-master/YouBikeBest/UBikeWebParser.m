//
//  UBikeWebParser.m
//  YouBikeBest
//
//  Created by injay on 13/5/20.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import "UBikeWebParser.h"
#import "TFHpple.h"
#import "Site.h"
#import "DataManager.h"
@implementation UBikeWebParser

+(void)startParsing:(CompletionBlock)finishBlock{
    
    [[[DataManager shareInstance]siteArray] removeAllObjects];
    NSArray *tutorialsNodes = [self nodesParsedWithUrl:@"http://www.youbike.com.tw/genxml9.php?"
                               //andQueryString:@"//table/tr/td/table/tr/td/table/tr/td/table/tr/td/a"];
                                        andQueryString:@"//markers/marker"];
    
    for (TFHppleElement *element in tutorialsNodes) {
        //NSLog(@"%@",[element attributes]);
        Site *UBikeSite = [[Site alloc]init];
        [UBikeSite setAddress:[[element attributes] valueForKey:@"address"]];
        [UBikeSite setLat:[[element attributes] valueForKey:@"lat"]];
        [UBikeSite setLng:[[element attributes] valueForKey:@"lng"]];
        [UBikeSite setName:[[element attributes] valueForKey:@"name"]];
        [UBikeSite setAvailBike:[[element attributes] valueForKey:@"tot"]]; //可租
        [UBikeSite setCapacity:[[element attributes] valueForKey:@"sus"]];  //可停
        [[[DataManager shareInstance]siteArray] addObject:UBikeSite];
    }
    NSLog(@"Finished.");
    finishBlock();
}


//+(void)startParsing:(CompletionBlock)finishBlock{
//    
//
//    
//    [[[DataManager shareInstance]siteArray] removeAllObjects];
//    
//    
//    NSArray *tutorialsNodes = [self nodesParsedWithUrl:@"http://www.youbike.com.tw/info04.php"
//                               //andQueryString:@"//table/tr/td/table/tr/td/table/tr/td/table/tr/td/a"];
//                                        andQueryString:@"//table/tr"];
//    
//    for (TFHppleElement *element in tutorialsNodes) {
//        
//        Site *UBikeSite = [[Site alloc]init];
//        for (TFHppleElement *child in element.children) {
//        
//            if ([child.tagName isEqualToString:@"td"] ) {
//                
//                for (TFHppleElement *childchild in child.children){
//                    
//                    if ([childchild.tagName isEqualToString:@"a"] ) {
//                        //NSLog(@"Station: %@",[childchild text]);
//                        [UBikeSite setName:[childchild text]];
//                    }
//                }
//                    
//                if ([[child objectForKey:@"class"] isEqualToString:@"point02"]) {
//                    //NSLog(@"可借 %@",[child text]);
//                    [UBikeSite setAvailBike:[child text]];
//                    
//                }else if([[child objectForKey:@"class"] isEqualToString:@"point03"]){
//                    //NSLog(@"可停 %@",[child text]);
//                    [UBikeSite setCapacity:[child text]];
//                    [[[DataManager shareInstance]siteArray] addObject:UBikeSite];
//                }
//                
//            }
//        }
//    }
//    NSLog(@"Finished.");
//    finishBlock();
//}


#pragma mark- basics

+(NSArray*)nodesParsedWithUrl:(NSString*)url andQueryString:(NSString*)queryString{
    
    // 1
    NSURL *tutorialsUrl = [NSURL URLWithString:url];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    // 2
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    
    // 3//<table class="views-view-grid">
    NSString *tutorialsXpathQueryString = queryString;
    NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
    
    return tutorialsNodes;
}



@end
