//
//  SQ_RefreshHeader.m
//  Siqiquan
//
//  Created by xiaohao liu on 16/11/16.
//  Copyright © 2016年 xiaohao liu. All rights reserved.
//

#import "SQ_RefreshHeader.h"

@implementation SQ_RefreshHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置状态文字颜色
        self.stateLabel.textColor = [UIColor blueColor];
        self.stateLabel.font = [UIFont systemFontOfSize:17];
        [self setTitle:@"赶紧下拉刷新" forState:MJRefreshStateIdle];
        [self setTitle:@"松开🐴上刷新" forState:MJRefreshStatePulling];
        [self setTitle:@"正在拼命刷新..." forState:MJRefreshStateRefreshing];
        // 隐藏时间
        self.lastUpdatedTimeLabel.hidden = YES;
        // 自动切换透明度
        self.automaticallyChangeAlpha = YES;
    }
    return self;
}


@end
