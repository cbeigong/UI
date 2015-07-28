//
//  FantasyTestViewController.m
//  FantasyWeibo
//
//  Created by clm on 15/7/6.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "FantasyTestViewController.h"
#import "FantasyTest1ViewController.h"
#import "UIView+Extension.h"

@interface FantasyTestViewController ()

@end

@implementation FantasyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    // 监听按钮事件
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    // 设置图片
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
//    // 设置尺寸
////    CGSize size = backBtn.currentBackgroundImage.size;
////    backBtn.frame = CGRectMake(0, 0, size.width, size.height);
//    backBtn.size = backBtn.currentBackgroundImage.size;
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    
//    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
//    // 设置图片
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
//    // 设置尺寸
//    moreBtn.size = moreBtn.currentBackgroundImage.size;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
//    
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)more
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    FantasyTest1ViewController *test1 = [[FantasyTest1ViewController alloc] init];
    test1.title = @"测试2控制器";
    // 往navigation上面push一层
    [self.navigationController pushViewController:test1 animated:YES];
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
