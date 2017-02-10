//
//  SQ_HomeViewController.m
//  Siqiquan
//
//  Created by xiaohao liu on 16/11/16.
//  Copyright © 2016年 xiaohao liu. All rights reserved.
//

#import "SQ_HomeViewController.h"
#import "TTCollectionView.h"
#import "PageScrollTableViewsController.h"

@interface SQ_HomeViewController ()<TTCollectionViewDelegate,UISearchBarDelegate>


@end

@implementation SQ_HomeViewController

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.title = @"思齐";
    [self addWebView];
    
    
//    [self addSecrchView];
//
//    [self addADScrollView];
//    [self addSubfieldView];
}


- (void)addWebView
{
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
//    [request setHTTPMethod:@"POST"];
//    [request setAllHTTPHeaderFields:headers];
    
    
    
    
    NSURL* url = [NSURL URLWithString:@"http://api.thinkwit.com/api/values/testAuth"];//创建URL
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    
//    [[NSUserDefaults standardUserDefaults] stringForKey:SECRETID]
    NSString *autoString = [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] stringForKey:Token]];
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    [mutableRequest addValue:autoString forHTTPHeaderField:@"Authorization"];
    [mutableRequest setHTTPShouldHandleCookies:YES];
    request = [mutableRequest copy];

    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, XMGScreenW, XMGScreenH)];
    [webView loadRequest:request];//加载
    [self.view addSubview:webView];
    
    
    
    
    
}

//- (void)setCookie{
//    
////    cookie = <NSHTTPCookie version:0 name:"Domain" value:"api.thinkwit.com" expiresDate:(null) created:2016-11-23 11:33:29 +0000 sessionOnly:TRUE domain:".api.thinkwit.com" partition:"none" path:"/" isSecure:FALSE>
//    
//    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//    [cookieProperties setObject:@"cookie_user" forKey:NSHTTPCookieName];
//    [cookieProperties setObject:@"api.thinkwit.com" forKey:NSHTTPCookieValue];
//    [cookieProperties setObject:@"http://api.thinkwit.com" forKey:NSHTTPCookieDomain];
//    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
//    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
//    [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
//    
//    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieProperties];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
//}


- (void)addSecrchView
{
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, XMGScreenW, 40)];
    searchBar.placeholder = @"请输入搜索内容";
    searchBar.barStyle = UISearchBarStyleMinimal;
    searchBar.delegate = self;
    UITextField *searchField1 = [searchBar valueForKey:@"_searchField"];
    searchField1.backgroundColor = [UIColor whiteColor];
    searchBar.tintColor = [UIColor lightGrayColor];
//    [self.navigationController.navigationBar addSubview:searchBar];
    
    [self.view addSubview:searchBar];
    
}

#pragma UISearchDelegate

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"haha");
    return YES;
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"click");
    
}


//滚动视图方法
- (void)addADScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    TTCollectionView *collection = [[TTCollectionView alloc] initWithFrame:CGRectMake(0, 104, kScreenWidth, 160)];
    collection.backgroundColor = [UIColor redColor];
    // 这里是设置轮播图的播放间隔
    collection.timeInterval = 3.0;
    // 这里直接传图片的URL字符串(切记是字符串), 要不你还要改里面的图片赋值语句
    collection.imagesArr = [NSArray arrayWithObjects:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1478486089&di=b3f06aec45d0a7cc90488c740ee4fc67&src=http://pic31.nipic.com/20130702/2926417_003653575119_2.jpg", @"http://d-smrss.oss-cn-beijing.aliyuncs.com/customerportrait/004/888/4f564995-a919-4c7f-ae8f-d8d0bda1d7f4_100x100.jpg", @"http://d-smrss.oss-cn-beijing.aliyuncs.com/customerportrait/004/869/2ebc752a-5176-4f16-b7b5-2233d4ddcc87_100x100.jpg", @"http://d-smrss.oss-cn-beijing.aliyuncs.com/customerportrait/004/888/4f564995-a919-4c7f-ae8f-d8d0bda1d7f4_100x100.jpg", @"http://d-smrss.oss-cn-beijing.aliyuncs.com/customerportrait/004/903/847d2925-7d03-40dd-90d9-429d13aabab8_100x100.jpg", nil];
    [self.view addSubview:collection];
    // 此属性一定要在collectionView添加到俯视图之后再设置, 这里是设置的轮播图数量
    collection.imagesCount = 5;
    // 设置代理(用来解决图片的点击事件)
    collection.collectionViewDelegate = self;
}

//滚动视图代理点击方法
#pragma mark - 这里实现cell的点击事件(根据index(也就是indexPath.item))
- (void)cellClickWithIndex:(NSInteger)index {
    
    NSLog(@"点击了第%ld张图片", index);
}

//分栏方法
- (void)addSubfieldView
{
    PageScrollTableViewsController * pageController = [[PageScrollTableViewsController alloc]initWithTitleArray:@[@"活动",@"视频",@"文章"]];
    pageController.view.frame = CGRectMake(0, 264, kScreenWidth, kScreenHeight - 264);
    [self.view addSubview:pageController.view];
    [self addChildViewController:pageController];
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
