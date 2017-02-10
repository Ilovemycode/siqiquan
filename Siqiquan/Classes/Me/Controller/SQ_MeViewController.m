//
//  SQ_MeViewController.m
//  Siqiquan
//
//  Created by xiaohao liu on 16/11/16.
//  Copyright © 2016年 xiaohao liu. All rights reserved.
//

#import "SQ_MeViewController.h"

@interface SQ_MeViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;


@property(nonatomic,assign)NSInteger *count;



@end

@implementation SQ_MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _count = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *url = [NSURL URLWithString: @"http://api.thinkwit.com/account/Login"];
    NSString *body = [NSString stringWithFormat: @"PhoneNum=%@&Password=%@", @"18516605890",@"123456"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    
    
    NSString *autoString = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] stringForKey:Token]];
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    [mutableRequest addValue:autoString forHTTPHeaderField:@"Authorization"];
    [mutableRequest setHTTPShouldHandleCookies:YES];
    request = [mutableRequest copy];
    
    
    
  
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, XMGScreenW, XMGScreenH)];
    [_webView loadRequest:request];//加载
    [self.view addSubview:_webView];
    
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
    
}

- (void)delayMethod
{
    NSURL* url = [NSURL URLWithString:@"http://api.thinkwit.com/WeChatHome/SiqiSpace"];//创建URL
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载

    
}



#pragma mark –webViewDelegate
-(BOOL)webView:(UIWebView* )webView shouldStartLoadWithRequest:(NSURLRequest* )request navigationType:(UIWebViewNavigationType)navigationType
{
    //网页加载之前会调用此方法
    
    //retrun YES 表示正常加载网页 返回NO 将停止网页加载
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载网页调用此方法
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成调用此方法
    if (_count < 1) {
        _count++;
        
        NSURL* url = [NSURL URLWithString:@"http://api.thinkwit.com/WeChatHome/SiqiSpace"];//创建URL
        
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, XMGScreenW, XMGScreenH)];
        [webView loadRequest:request];//加载
        
        
        
    }
    
    
    
}

-(void)webView:(UIWebView* )webView didFailLoadWithError:(NSError* )error
{ 
    //网页加载失败 调用此方法 
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
