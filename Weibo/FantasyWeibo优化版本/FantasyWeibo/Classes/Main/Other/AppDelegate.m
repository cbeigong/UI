//
//  AppDelegate.m
//  FantasyWeibo
//
//  Created by clm on 15/7/2.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "AppDelegate.h"
#import "FantasytabBarViewController.h"
#import "FTNewFeatureViewController.h"
#import "FTOAuthViewController.h"



// RGB颜色
#define FantasyColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define FantasyRandomColor FantasyColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 1.创建窗口哦
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.设置控制器 最下面的那一条tabbar
//    UITabBarController *tabbarVc = [[FantasyTabBarViewController alloc] init];
//    self.window.rootViewController = tabbarVc;
    self.window.rootViewController = [[FTOAuthViewController alloc] init];
    
//    // 2.设置根控制器
//    NSString *key = @"CFBundleVersion";
//    // 上一次的使用版本（存储在沙盒中的版本号）
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//    // 当前软件的版本号（从Info.plist中获得）
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
//    
//    if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
//        self.window.rootViewController = [[FantasyTabBarViewController alloc] init];
//    } else { // 这次打开的版本和上一次不一样，显示新特性
//        self.window.rootViewController = [[FTNewFeatureViewController alloc] init];
//        
//        // 将当前的版本号存进沙盒
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//

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
//    UIViewController *vc1 = [[UIViewController alloc] init];
//    vc1.view.backgroundColor = FantasyRandomColor;
//    vc1.tabBarItem.title = @"首页";
//    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
//
//    // 设置文字的样式 其中setTitleTextAttributes时在iOS7中才有的
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
//    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
//    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//
//    [vc1.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [vc1.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
//
//    // 因为默认你把selected图片赋值给tabBarItem的图片的时候，它会被渲染成蓝色的，如果要现实原来点颜色的话，要进行渲染的方法的调用比如imageWithRenderingMode
//    vc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//
//    UIViewController *vc2 = [[UIViewController alloc] init];
//    vc2.view.backgroundColor = FantasyRandomColor;
//    vc2.tabBarItem.title = @"消息";
//    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
//    vc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_message_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
////    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];颜色对dictionary只需要设置一次就好
//    [vc2.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [vc2.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
//
//
//
//
//    UIViewController *vc3 = [[UIViewController alloc] init];
//    vc3.view.backgroundColor = FantasyRandomColor;
//    vc3.tabBarItem.title = @"发现";
//    vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
//    vc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//    // 根据文字选中以及没有选中的状态去给文字赋值
//    [vc3.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [vc3.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
//
//

