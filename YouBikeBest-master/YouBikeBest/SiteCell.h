//
//  SiteCell.h
//  YouBikeBest
//
//  Created by injay on 13/5/9.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiteCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel* lbName;
@property (nonatomic,strong) IBOutlet UILabel* lbCanRent;
@property (nonatomic,strong) IBOutlet UILabel* lbCanPark;


@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* canRent;
@property (nonatomic,strong) NSString* canPark;


-(void)setName:(NSString *)name;
-(void)setCanRent:(NSString *)canRent;

-(void)setCanPark:(NSString *)canPark;

@end
