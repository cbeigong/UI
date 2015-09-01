//
//  MTHomeTopItem.m
//  美团HD
//
//  Created by clm on 15/8/17.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTHomeTopItem.h"

@interface MTHomeTopItem ()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end


@implementation MTHomeTopItem

// 设置MTHomeTopItem不会自动拉伸，只要是哪个控件自动拉伸，就对对应的那个控件进行设置。
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

// 只需要传递对象和所要进行的方法 实现了对按钮的封装。
- (void)addTarget:(id)target action:(SEL)action
{
    return [self.iconButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

+ (instancetype)item
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MTHomeTopItem" owner:nil options:nil] firstObject];
}

- (void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon
{
    [self.iconButton setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.iconButton setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    self.subtitleLabel.text = subtitle;
}


@end
