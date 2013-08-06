//
//  TimerViewController.h
//  YouBikeBest
//
//  Created by injay on 13/6/4.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondContentViewController.h"
@interface TimerViewController :SecondContentViewController <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSTimer *xtimer;
@property (strong, nonatomic) IBOutlet UITableView *tbView;
@property (strong, nonatomic) NSArray* notifArray;
@end
