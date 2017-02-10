//
//  AppDelegate.m
//  Siqiquan
//
//  Created by xiaohao liu on 16/11/15.
//  Copyright © 2016年 xiaohao liu. All rights reserved.
//

//   APPID wxc4f03a025256584a
//  APPSect      fc9eb7668e235fb33b05808772d97c41


#import "AppDelegate.h"
#import "SQ_HomeViewController.h"
#import "SQ_TabbarController.h"
#import "MMZCViewController.h"
#import <AFNetworking.h>
#import "WXApi.h"
#import "SQ_TabbarController.h"

#import "AFNetworking_RequestData.h"


@interface AppDelegate ()<WXApiDelegate>
{
    SQ_HomeViewController *homeVC;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatDidLoginNotification:) name:@"wechatDidLoginNotification" object:nil];

    
    
//    cookie = <NSHTTPCookie version:0 name:"COOKIE_NAME" value:"COOKIE_VALUE" expiresDate:(null) created:2016-11-23 11:48:11 +0000 sessionOnly:TRUE domain:"api.thinkwit.com" partition:"none" path:"" isSecure:FALSE>
    
    
//    NSURL *cookieHost = [NSURL URLWithString:@"http://api.thinkwit.com"];
//    NSDictionary *propertiesDict = [NSDictionary dictionaryWithObjectsAndKeys:[cookieHost host],NSHTTPCookieDomain,[cookieHost path],NSHTTPCookiePath,@"COOKIE_NAME",NSHTTPCookieName,@"COOKIE_VALUE",NSHTTPCookieValue,nil];
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:propertiesDict];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//    
//    
//    NSHTTPCookieStorage *cook = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    [cook setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    MMZCViewController *login=[[MMZCViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:login];
    self.window.rootViewController=nav;
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1],NSForegroundColorAttributeName,nil];
    [nav.navigationBar setTitleTextAttributes:attributes];

    
    //向微信注册
//    [WXApi registerApp:kWeiXinAppId];
    [WXApi registerApp:kWeiXinAppId withDescription:@"wechat"];

    

    
    return YES;
}

-(void)wechatDidLoginNotification:(NSString *)str
{
    
    
}




//和QQ,新浪并列回调句柄
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

//授权后回调 WXApiDelegate
-(void)onResp:(BaseReq *)resp
{
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    
    if ([resp isKindOfClass:[SendAuthResp class]]) //判断是否为授权请求，否则与微信支付等功能发生冲突
    {
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode== 0)
        {
            NSLog(@"code %@",aresp.code);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatDidLoginNotification" object:self userInfo:@{@"code":aresp.code}];
            
            [self getWechatAccessTokenWithCode:aresp.code];
        }
    }
}
//
//#define kWeiXinAppId               @"wxc4f03a025256584a"
//#define kWeiXinAppSecret


- (void)getWechatAccessTokenWithCode:(NSString *)code
{
    NSString *url =[NSString stringWithFormat:
                    @"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",
                    kWeiXinAppId,kWeiXinAppSecret,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data)
            {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingMutableContainers error:nil];
                
                NSLog(@"%@",dic);
                NSString *accessToken = dic[@"access_token"];
                NSString *openId = dic[@"openid"];
                NSString *unionId = dic[@"unionid"];

                
                
                //通过微信三方授权获得的accessToken来登录
                [self loginWithAccess_Token:accessToken unionId:unionId];
                
                
                //获取微信号信息
//                [self getWechatUserInfoWithAccessToken:accessToken openId:openId];
            }
        });
    });  
}


- (void)loginWithAccess_Token:(NSString *)access_token unionId:(NSString *)unionid
{
    
    NSString *loginUrl = [NSString stringWithFormat:@"http://api.thinkwit.com/account/wechatlLogin?providerKey=%@",unionid];
    NSLog(@"loginUrl = %@",loginUrl);
   
//    
//    NSURL *url=[NSURL URLWithString:loginUrl];//创建URL
//    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];//通过URL创建网络请求
//    [request setTimeoutInterval:30];//设置超时时间
//    [request setHTTPMethod:@"GET"];//设置请求方式
//    NSError *err;
//    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
//    NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"\n string:%@\n",str);
//    NSLog(@"\n err:%@\n",err);

    
    
    SQ_TabbarController *login=[[SQ_TabbarController alloc]init];
//    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:login];
    self.window.rootViewController=login;
    
    
    
//    NSDictionary *loginDict = @{@"providerKey":access_token};
//    
//    NSLog(@"loginDict = %@",loginDict);
//
    [AFNetworking_RequestData requestMethodGetUrl:loginUrl dic:nil Succed:^(id responseObject) {
        
        
        NSLog(@"%@",responseObject);
        NSDictionary *loginResponObject = [NSDictionary dictionaryWithDictionary:responseObject];
        
        SHOW_ALERT(loginResponObject[@"access_token"]);
        SetDefaults(Token, loginResponObject[@"access_token"]);
        
        
        //        [self presentViewController:[[SQ_TabbarController alloc]init] animated:YES completion:nil];
        SQ_TabbarController *tabbar=[[SQ_TabbarController alloc]init];
        self.window.rootViewController=tabbar;

    
    } failure:^(NSError *error) {
        
        NSLog(@"error = %@",error);
        
    }];

    
    
//    POST
//    [AFNetworking_RequestData requestMethodPOSTUrl:loginUrl dic:loginDict Succed:^(id responseObject) {
//        
//        
//        NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        for (NSHTTPCookie *cookie in [myCookie cookies]) {
//            NSLog(@"cookie = %@", cookie);
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie]; // 保存
//        }
//        
//        
//        NSLog(@"%@",responseObject);
//        NSDictionary *loginResponObject = [NSDictionary dictionaryWithDictionary:responseObject];
//        
//        SHOW_ALERT(loginResponObject[@"access_token"]);
//        SetDefaults(Token, loginResponObject[@"access_token"]);
//        
//        
////        [self presentViewController:[[SQ_TabbarController alloc]init] animated:YES completion:nil];
//        SQ_TabbarController *tabbar=[[SQ_TabbarController alloc]init];
//        self.window.rootViewController=tabbar;
//        
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//    }];

    
}




- (void)getWechatUserInfoWithAccessToken:(NSString *)accessToken openId:(NSString *)openId
{
    NSString *url =[NSString stringWithFormat:
                    @"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data)
            {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingMutableContainers error:nil];
                
                NSLog(@"%@",dic);
                
                NSString *openId = [dic objectForKey:@"openid"];
                NSString *memNickName = [dic objectForKey:@"nickname"];
                NSString *memSex = [dic objectForKey:@"sex"];
                
//                [self loginWithOpenId:openId memNickName:memNickName memSex:memSex];
            }
        });
        
    });
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"wechatDidLoginNotification" object:nil];
}


@end
