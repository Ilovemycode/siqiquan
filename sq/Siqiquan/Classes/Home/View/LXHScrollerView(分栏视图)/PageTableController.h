//
//  PageTableController.h
//  ScrollViewAndTableView
//
//  Created by fantasy on 16/5/14.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^TableViewDidScrollBlock)(CGFloat tableViewOffsetY);

@interface PageTableController : UITableViewController

@property (assign, nonatomic) int numOfController;

@property (copy, nonatomic) TableViewDidScrollBlock tableViewDidScroll;

@end
