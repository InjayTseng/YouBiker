//
//  SettingsViewController.h
//  YouBikeBest
//
//  Created by injay on 13/5/14.
//  Copyright (c) 2013年 injay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewBasicController.h"

@interface SettingsViewController : ContentViewBasicController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tbView;

@end
