//
//  SQ_TabbarController.m
//  Siqiquan
//
//  Created by xiaohao liu on 16/11/16.
//  Copyright © 2016年 xiaohao liu. All rights reserved.
//

#import "SQ_TabbarController.h"
#import "SQ_HomeViewController.h"
#import "SQ_RecommendViewController.h"
#import "SQ_MeViewController.h"
#import "UIImage+Image.h"
#import "SQ_NavigationController.h"
#import "SQ_TabBar.h"

@interface SQ_TabbarController ()

@end

@implementation SQ_TabbarController

//只调用一次
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Do any additional setup after loading the view.
    // 1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    // 2 设置tabBar上按钮内容 -> 由对应的子控制器的tabBarItem属性
    [self setupAllTitleButton];
    
    // 3.自定义tabBar
    [self setupTabBar];
    
}


#pragma mark - 自定义tabBar
- (void)setupTabBar
{
    SQ_TabBar *tabBar = [[SQ_TabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

/*
 Changing the delegate of a tab bar 【managed by a tab bar controller】 is not allowed.
 被UITabBarController所管理的UITabBar的delegate是不允许修改的
 */

#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{
    SQ_HomeViewController *homeVC = [[SQ_HomeViewController alloc]init];
    SQ_NavigationController *homeNav = [[SQ_NavigationController alloc]initWithRootViewController:homeVC];
    [self addChildViewController:homeNav];
    
    SQ_RecommendViewController *recommendVC = [[SQ_RecommendViewController alloc]init];
    SQ_NavigationController *recommendNav = [[SQ_NavigationController alloc]initWithRootViewController:recommendVC];
    [self addChildViewController:recommendNav];
    
    SQ_MeViewController *meVC = [[SQ_MeViewController alloc]init];
    SQ_NavigationController *meNav = [[SQ_NavigationController alloc]initWithRootViewController:meVC];
    [self addChildViewController:meNav];
    
    // 精华
//    XMGEssenceViewController *essenceVc = [[XMGEssenceViewController alloc] init];
//    XMGNavigationViewController *nav = [[XMGNavigationViewController alloc] initWithRootViewController:essenceVc];
//    // initWithRootViewController:push
//    [self addChildViewController:nav];
//    
//    // 新帖
//    XMGNewViewController *newVc = [[XMGNewViewController alloc] init];
//    XMGNavigationViewController *nav1 = [[XMGNavigationViewController alloc] initWithRootViewController:newVc];
//    [self addChildViewController:nav1];
//    
//    // 关注
//    XMGFriendTrendViewController *ftVc = [[XMGFriendTrendViewController alloc] init];
//    XMGNavigationViewController *nav3 = [[XMGNavigationViewController alloc] initWithRootViewController:ftVc];
//    [self addChildViewController:nav3];
//    
//    // 我
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([XMGMeViewController class]) bundle:nil];
//    // 加载箭头指向控制器
//    XMGMeViewController *meVc = [storyboard instantiateInitialViewController];
//    XMGNavigationViewController *nav4 = [[XMGNavigationViewController alloc] initWithRootViewController:meVc];
//    [self addChildViewController:nav4];
}

// 设置tabBar上所有按钮内容
- (void)setupAllTitleButton
{
    // 0:nav
    UINavigationController *homeNav = self.childViewControllers[0];
    homeNav.tabBarItem.title = @"精华";
    homeNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    // 快速生成一个没有渲染图片
    homeNav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    // 1:新帖
    UINavigationController *meNav = self.childViewControllers[1];
    meNav.tabBarItem.title = @"新帖";
    meNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    meNav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    // 3.关注
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
//    // 4.我
//    UINavigationController *nav4 = self.childViewControllers[3];
//    nav4.tabBarItem.title = @"我";
//    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
//    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
    
}



@end
