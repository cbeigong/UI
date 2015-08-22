//
//  MTDistrictViewController.m
//  美团HD
//
//  Created by clm on 15/8/20.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTDistrictViewController.h"
#import "MTHomeDropdown.h"
#import "UIView+Extension.h"
#import "MTCityViewController.h"
#import "MTNavigationController.h"

@interface MTDistrictViewController ()
- (IBAction)changeCity;

@end

@implementation MTDistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 因为UIViewController中只有一个UIView所以用的是firstObject
    UIView *titleBar = [self.view.subviews firstObject];
    
    MTHomeDropdown *dropdown = [MTHomeDropdown dropdown];
    dropdown.backgroundColor = [UIColor redColor];
    
    // 因为是要添加到UIView上面去的。
    dropdown.y = titleBar.height;
    
    // 添加dropdown控件
    [self.view addSubview:dropdown];
    
    // 下面的这行代码就是让popover出来的东西的大小等于下拉菜单的大小。
    self.preferredContentSize = dropdown.size;//CGSizeMake(dropdown.width, CGRectGetMaxY(dropdown.frame));
}

- (IBAction)changeCity {
    MTCityViewController *city = [[MTCityViewController alloc] init];
    
    // 包装MTCityViewController进导航栏
    MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:city];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    NSLog(@"%@", self);
    
    // 只要是UIViewController，一般都有presentVeiwController 这样的功能
    [self presentViewController:nav animated:YES completion:nil];
}
@end




//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */