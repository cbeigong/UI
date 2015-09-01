//
//  MTSortViewController.m
//  美团HD
//
//  Created by clm on 15/9/1.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTSortViewController.h"
#import "MTMetaTool.h"
#import "MTSort.h"
#import "UIView+Extension.h"
#import "MTConst.h"
@interface MTSortButton : UIButton
// 每个button 里面含有一个sort模型
@property (nonatomic, strong) MTSort *sort;
@end

@interface MTSortViewController ()

@end
@implementation MTSortButton

- (instancetype)initWithFrame:(CGRect)frame
{
    // 基本设置
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)setSort:(MTSort *)sort
{
    // 传进去模型的时候同时设置button的名字
    _sort = sort;
    [self setTitle:sort.label forState:UIControlStateNormal];
}

@end

@implementation MTSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *sorts = [MTMetaTool sorts];
    NSUInteger count = sorts.count;
//    CGFloat b
    CGFloat btnW = 100;
    CGFloat btnH = 30;
    CGFloat btnMargin = 10;
    CGFloat height = 0;
    CGFloat btnStartY = 15;
    for (NSUInteger i = 0; i < count; i++) {
        MTSortButton *button = [[MTSortButton alloc] init];
        button.sort = sorts[i];
        button.width = btnW;
        button.height = btnH;
//        button.backgroundColor = [UIColor redColor];
        button.x = 0;
        button.y = btnStartY + i * (btnH + btnMargin);
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        height = CGRectGetMaxY(button.frame);
    }
    
    self.preferredContentSize = CGSizeMake(btnW, height);
    
}

- (void)buttonClick:(MTSortButton *)button
{
    [MTNotificationCenter postNotificationName:MTSortDidChangeNotification object:nil userInfo:@{MTSelectSort : button.sort}];
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
