//
//  FTSearchBar.m
//  FantasyWeibo
//
//  Created by clm on 15/7/21.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "FTSearchBar.h"
#import "UIView+Extension.h"

@implementation FTSearchBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

//1、instancetype只能用于方法的返回类型，而id用处和NSObject *类似。
//
//2、instancetype会告诉编译器当前的类型，这点和NSObject *类似，但id对于编译器却是无类型的，调用任何方法不会给出错误提示。
//
//3、对于init方法，id和instancetype是没有区别的。因为编译器会把id优化成instancetype。当明确返回的类型就是当前Class时，使用instancetype能避免id带来的编译不出的错误情况。
//
//4、NSObject Class和id都是仅包含了一个Class isa。但NSObject 包含了更多方法的定义。
//
//5、id和instancetype都能省去具体类型，提高代码的通用性。而这是NSObject *不及的。
//
//6、个人认为：instancetype是对id和NSObject *两者不足的一个补充。
//
//1、instancetype只能用于方法的返回类型，而id用处和NSObject *类似。
//
//2、instancetype会告诉编译器当前的类型，这点和NSObject *类似，但id对于编译器却是无类型的，调用任何方法不会给出错误提示。
//
//3、对于init方法，id和instancetype是没有区别的。因为编译器会把id优化成instancetype。当明确返回的类型就是当前Class时，使用instancetype能避免id带来的编译不出的错误情况。
//
//4、NSObject Class和id都是仅包含了一个Class isa。但NSObject 包含了更多方法的定义。
//
//5、id和instancetype都能省去具体类型，提高代码的通用性。而这是NSObject *不及的。
//
//6、个人认为：instancetype是对id和NSObject *两者不足的一个补充。


@end
