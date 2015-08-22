//
//  ViewController.m
//  02-Popover的其他的用法
//
//  Created by clm on 15/8/15.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "ViewController.h"
#import "HMColorsViewController.h"

@interface ViewController () <HMColorsViewControllerDelegate, UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *another;
@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, weak) UIButton *colorButton;

- (IBAction)anotherClick:(UIButton *)another;

- (IBAction)buttonClick:(UIButton *)btn;

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)anotherClick:(UIButton *)another {
    [self.popover dismissPopoverAnimated:YES];
}

- (IBAction)buttonClick:(UIButton *)btn {
    // 0 内容
    HMColorsViewController *colors = [[HMColorsViewController alloc] init];
    colors.delegate = self;
    
    // 1 创建
    self.popover = [[UIPopoverController alloc] initWithContentViewController:colors];
    self.popover.delegate = self;
    
    // 2.显示
    [self.popover presentPopoverFromRect:btn.bounds inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    // 设置那里控件在popover显示出来的时候仍然可以跟用户进行交互
    self.popover.passthroughViews = @[self.another];
    self.colorButton = btn;
    
}

#pragma - 颜色代理
- (void)colorSViewController:(HMColorsViewController *)vc didSelectColor:(UIColor *)color
{
    self.colorButton.backgroundColor = color;
    
    [self.popover dismissPopoverAnimated:YES];
}

@end
