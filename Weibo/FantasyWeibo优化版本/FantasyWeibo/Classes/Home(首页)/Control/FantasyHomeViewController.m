//
//  FantasyHomeViewController.m
//  FantasyWeibo
//
//  Created by clm on 15/7/5.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "FantasyHomeViewController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "FTDropdownMenu.h"
#import "FTTitleMenuViewController.h"

// RGB颜色
#define FantasyColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define FantasyRandomColor FantasyColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));


@interface FantasyHomeViewController () <FTDropdownMenuDelegate>

@property (nonatomic, strong) FTTitleMenuViewController *vc;

@end

@implementation FantasyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* 中间的标题按钮 */
    //    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.width = 150;
    titleButton.height = 30;
//    titleButton.backgroundColor = FantasyRandomColor;
    
    // 设置图片和文字
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];

//    titleButton.imageView.backgroundColor = [UIColor redColor];
//    titleButton.titleLabel.backgroundColor = [UIColor blueColor];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    
    self.navigationItem.titleView = titleButton;
    
    // 监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    // 如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸
//    
//    UITextField *field = [[UITextField alloc] init];
//    field.backgroundColor = [UIColor redColor];
//    field.width = 100;
//    field.height = 30;
//    [self.view addSubview:field];

}

/**
 *  标题点击
 */
- (void)titleClick:(UIButton *)titleButton
{
//    // 这样获得的窗口，是目前显示在屏幕最上面的窗口
//    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//    
//    // 添加蒙板（用于拦截灰色图片外面的点击事件）
//    UIView *cover = [[UIView alloc] init];
//    cover.backgroundColor = [UIColor clearColor];
//    cover.frame = window.bounds;
//    [window addSubview:cover];
//
//    // 添加带箭头的灰色图片
//    UIImageView *dropdownMenu = [[UIImageView alloc] init];
//    dropdownMenu.image = [UIImage imageNamed:@"popover_background"];
//    dropdownMenu.width = 217;
//    dropdownMenu.height = 217;
//    dropdownMenu.y = 40;
//    
//    [dropdownMenu addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    FTDropdownMenu *menu = [FTDropdownMenu menu];
    menu.delegate = self;
    
    // 2.设置内容
    FTTitleMenuViewController *vc = [[FTTitleMenuViewController alloc] init];
    vc.view.height = 150;
    vc.view.width = 150;
    self.vc = vc;
    menu.contentController = vc;
    
    // 3.显示
    [menu showFrom:titleButton];}
    
    // self.view.window = [UIApplication sharedApplication].keyWindow
    // 当控制器的view没有添加到窗口的时候self.view.window 是空的 而右边的是有的
    // 建议使用[UIApplication sharedApplication].keyWindow获得窗口  因为程序一旦启动 就有主窗口
    
//    NSLog(@"%@", [UIApplication sharedApplication].windows);
- (void)friendSearch
{
    NSLog(@"friendSearch");
}

- (void)pop
{
    NSLog(@"pop");
}

#pragma mark - HWDropdownMenuDelegate
/**
 *  下拉菜单被销毁了
 */
- (void)dropdownMenuDidDismiss:(FTDropdownMenu *)menu
{
    //利用self.navigationItem.titleView获取titleButton
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
    // 让箭头向下
//        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

/**
 *  下拉菜单显示了
 */
- (void)dropdownMenuDidShow:(FTDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
    // 让箭头向上
//        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}



@end
