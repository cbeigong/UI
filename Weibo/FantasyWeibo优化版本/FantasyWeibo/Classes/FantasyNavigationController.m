//
//  FantasyNavigationController.m
//  FantasyWeibo
//
//  Created by clm on 15/7/6.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "FantasyNavigationController.h"
#import "UIView+Extension.h"

@implementation FantasyNavigationController


/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"%@", viewController);
    
    if (self.viewControllers.count > 0) {// 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 监听按钮事件
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 设置图片
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        // 设置尺寸
        //    CGSize size = backBtn.currentBackgroundImage.size;
        //    backBtn.frame = CGRectMake(0, 0, size.width, size.height);
        backBtn.size = backBtn.currentBackgroundImage.size;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        // 设置图片
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        // 设置尺寸
        moreBtn.size = moreBtn.currentBackgroundImage.size;
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
        

    }
    // 把下面的这行代码放在下面的话，一开始push第一个controller的时候，并不会设置左右的navigationItem的左右btn直到，等到后第二次pushcontroller的时候就要设置上面的navigationItem多左右图标了 。
    [super pushViewController:viewController animated:animated];

    
   
}

- (void)back
{
#warning 这里要用self，不是self.navigationController
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
