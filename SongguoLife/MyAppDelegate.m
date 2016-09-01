//
//  MyAppDelegate.m
//  SongguoLife
//
//  Created by Apple on 16/9/1.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "MyAppDelegate.h"
#import <YTKNetworkConfig.h>
#import "HLLTabbarViewController.h"

@implementation MyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:BACK_COLOR]];
    [UINavigationBar appearance].clipsToBounds = YES;
    
    // 设置网络配置文件
    [YTKNetworkConfig sharedInstance].baseUrl = @"http://songguolife.com/api";
    
    self.window.rootViewController = [HLLTabbarViewController new];
    
    return YES;
}

@end
