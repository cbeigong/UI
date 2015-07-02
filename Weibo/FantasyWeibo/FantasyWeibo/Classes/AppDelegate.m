//
//  AppDelegate.m
//  FantasyWeibo
//
//  Created by clm on 15/7/2.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "AppDelegate.h"
// 随机色
#define FantasyRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 1.创建窗口哦
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.设置控制器 最下面的那一条tabbar
    UITabBarController *tabbarVc = [[UITabBarController alloc] init];
    self.window.rootViewController = tabbarVc;
    
    // 3. 设置子控制器
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = FantasyRandomColor;
    vc1.tabBarItem.title = @"首页";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = FantasyRandomColor;
    vc2.tabBarItem.title = @"消息";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = FantasyRandomColor;
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = FantasyRandomColor;
    
    UIViewController *vc5 = [[UIViewController alloc] init];
    vc5.view.backgroundColor = FantasyRandomColor;
    
//    tabbarVc.viewControllers = @[vc1, vc2, vc3, vc4, vc5];
    // 第二种写法
    [tabbarVc addChildViewController:vc1];
    [tabbarVc addChildViewController:vc2];
    [tabbarVc addChildViewController:vc3];
    [tabbarVc addChildViewController:vc4];
    [tabbarVc addChildViewController:vc5];

    // 4.显示窗口
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
