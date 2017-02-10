//
//  PageTableController.m
//  ScrollViewAndTableView
//
//  Created by fantasy on 16/5/14.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "PageTableController.h"

//#import "Common.h"

@interface PageTableController ()

@property (strong, nonatomic) NSArray * titleArray;

@end

@implementation PageTableController


- (instancetype)init{
  
  if (self = [super init]) {
     self.automaticallyAdjustsScrollViewInsets = NO;
  }
  return self;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
//  return self.numOfController * 5;//TODO: (fantasy) bug fix;
  return 10;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  static NSString * cellId = @"PageTableController";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
  if (cell == nil) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellId];
  }
  cell.detailTextLabel.text = [NSString stringWithFormat:@"第%d个控制器－－－－第%ld行",self.numOfController,(long)indexPath.row+1];
  return cell;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //点击事件
    NSLog(@"%@",[NSString stringWithFormat:@"第%d个控制器－－－－第%ld行",self.numOfController,(long)indexPath.row+1]);
    
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
  if (scrollView == self.tableView && self.tableViewDidScroll) {
    
    self.tableViewDidScroll(self.tableView.contentOffset.y);
    
  }
  
}

@end
