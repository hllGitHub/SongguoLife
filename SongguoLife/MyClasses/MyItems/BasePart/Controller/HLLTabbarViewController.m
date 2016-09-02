//
//  HLLTabbarViewController.m
//  SongguoLife
//
//  Created by Apple on 16/9/1.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLTabbarViewController.h"
#import "HLLHomeViewController.h"       // 首页
#import "HLLExploreViewController.h"    // 探索
#import "HLLActivityViewController.h"   // 活动
#import "HLLMeViewController.h"         // 我的

@interface HLLTabbarViewController ()

@end

@implementation HLLTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : TITLE_NORMAL_COLOR, NSFontAttributeName : [UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : TITLE_HIGHLIGHT_COLOR, NSFontAttributeName : [UIFont systemFontOfSize:12.f]} forState:UIControlStateSelected];
    UIOffset offset = {0.f, -3.f};
    [[UITabBarItem appearance] setTitlePositionAdjustment:offset];
    
    self.tabBar.backgroundColor = BACK_COLOR;
    [self createViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initial data and view
- (void)createViewControllers {
    // 首页
    HLLHomeViewController *homeVC = [[HLLHomeViewController alloc]init];
    [self setViewController:homeVC
                      title:@"精选"
                normalImage:[UIImage imageNamed:@"tab_home"]
           andSelectedImage:[UIImage imageNamed:@"tab_home_active"]];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    // 探索
    HLLExploreViewController *exploreVC = [[HLLExploreViewController alloc]init];
    [self setViewController:exploreVC
                      title:@"探索"
                normalImage:[UIImage imageNamed:@"tab_explore"]
           andSelectedImage:[UIImage imageNamed:@"tab_explore_active"]];
    UINavigationController *exploreNav = [[UINavigationController alloc]initWithRootViewController:exploreVC];
    
    // 活动
    HLLActivityViewController *activityVC = [[HLLActivityViewController alloc]init];
    [self setViewController:activityVC
                      title:@"活动"
                normalImage:[UIImage imageNamed:@"tab_event"]
           andSelectedImage:[UIImage imageNamed:@"tab_event_active"]];
    UINavigationController *activityNav = [[UINavigationController alloc]initWithRootViewController:activityVC];
    
    // 我的
    HLLMeViewController *meVC = [[HLLMeViewController alloc]init];
    [self setViewController:meVC
                      title:@"我"
                normalImage:[UIImage imageNamed:@"tab_me"]
           andSelectedImage:[UIImage imageNamed:@"tab_me_active"]];
    UINavigationController *meNav = [[UINavigationController alloc]initWithRootViewController:meVC];
    
    self.viewControllers = @[homeNav, exploreNav, activityNav, meNav];
}

/**
 *  设置子视图控制器
 *
 *  @param viewController 需要设置的控制器
 *  @param title          tabbar显示标题
 *  @param normalImage    正常显示图片
 *  @param selectedImage  选中显示图片
 */
- (void)setViewController:(BaseViewController *)viewController
                    title:(NSString *)title
              normalImage:(UIImage *)normalImage
         andSelectedImage:(UIImage *)selectedImage {
    viewController.title = title;
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
