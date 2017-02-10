//
//  SQ_HTTPSessionManager.m
//  Siqiquan
//
//  Created by xiaohao liu on 16/11/16.
//  Copyright © 2016年 xiaohao liu. All rights reserved.
//

#import "SQ_HTTPSessionManager.h"

@implementation SQ_HTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
        [self.requestSerializer setValue:[UIDevice currentDevice].model forHTTPHeaderField:@"Phone"];
        [self.requestSerializer setValue:[UIDevice currentDevice].systemVersion forHTTPHeaderField:@"OS"];
    }
    return self;
}

@end
