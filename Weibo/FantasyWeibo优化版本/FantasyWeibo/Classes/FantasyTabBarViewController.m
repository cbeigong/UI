//
//  FantasyTabBarViewController.m
//  FantasyWeibo
//
//  Created by clm on 15/7/5.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "FantasyTabBarViewController.h"
#import "FantasyHomeViewController.h"
#import "FantasyDiscoverViewController.h"
#import "FantasyProfileViewController.h"
#import "FantasyMessageCenterViewController.h"



// RGB颜色
#define FantasyColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define FantasyRandomColor FantasyColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
@interface FantasyTabBarViewController ()

@end

@implementation FantasyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FantasyHomeViewController *homeView = [[FantasyHomeViewController alloc] init];
    [self addChildVc:homeView title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    FantasyMessageCenterViewController *discoverView = [[FantasyMessageCenterViewController alloc] init];
    [self addChildVc:discoverView title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    
    FantasyDiscoverViewController *messageCenter =[[FantasyDiscoverViewController alloc] init];
    [self addChildVc:messageCenter title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    FantasyProfileViewController *profile = [[FantasyProfileViewController alloc] init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tababr_profile_selected"];
    

    
}


- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedimage
{
    
    //    UIViewController *childVc = [[UIViewController alloc] init];
  
    childVc.view.backgroundColor = FantasyRandomColor;
//    childVc.tabBarItem.title = title; //设置tabbar的文字
//    childVc.navigationItem.title = title; //设置navigationBar的文字
      //  设置控制器的文字
    childVc.title = title; //同时设置tabbar 和 navigationBar的文字
    
    // 设置控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式 其中setTitleTextAttributes时在iOS7中才有的
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 先把传进来的UItabbleViewController包装进导航栏控制器。
    UINavigationController  *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    
    // 添加为UItabBarController的子控制器
    [self addChildViewController:nav];
    
    
    // return childVc;
    
    
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
