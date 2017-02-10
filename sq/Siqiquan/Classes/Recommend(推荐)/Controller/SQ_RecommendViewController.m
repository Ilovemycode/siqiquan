//
//  SQ_RecommendViewController.m
//  Siqiquan
//
//  Created by xiaohao liu on 16/11/18.
//  Copyright © 2016年 xiaohao liu. All rights reserved.
//

#import "SQ_RecommendViewController.h"

@interface SQ_RecommendViewController ()

@end

@implementation SQ_RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self addWebView];
}

- (void)addWebView
{
    
    
    NSURL* url = [NSURL URLWithString:@"http://api.thinkwit.com/WeChatHome/SiqiSpace"];//创建URL
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, XMGScreenW, XMGScreenH)];
    [webView loadRequest:request];//加载
    [self.view addSubview:webView];
    
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
