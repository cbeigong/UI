//
//  MTCityViewController.m
//  美团HD
//
//  Created by clm on 15/8/20.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTCityViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+AutoLayout.h"
#import "MJExtension.h"
#import "MTCityGroup.h"
#import "MTConst.h"
#import "MTCitySearchResultViewController.h"
#import "MTCity.h"
#import "MTCityGroup.h"



@interface MTCityViewController () <UISearchBarDelegate ,UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cover;
- (IBAction)coverClick;
@property (strong, nonatomic) NSArray *cityGroups;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, weak) MTCitySearchResultViewController *citySearchResult;


@end


@implementation MTCityViewController
// 再implementation里面进行书写
- (MTCitySearchResultViewController *)citySearchResult
{
    if (!_citySearchResult) {
        MTCitySearchResultViewController *citySearchResult = [[MTCitySearchResultViewController alloc] init];
        [self addChildViewController:citySearchResult];
        self.citySearchResult = citySearchResult;
        
        // 此处是进行autolayout的约束
        [self.view addSubview:self.citySearchResult.view];
        [self.citySearchResult.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.citySearchResult.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar withOffset:15];
    }
    return _citySearchResult;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换城市";
    NSLog(@"%@", self);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"btn_navigation_close" highImage:@"btn_navigation_closo_hl"];
    // 设置tableView右边索引的颜色
    self.tableView.sectionIndexColor = [UIColor blackColor];
    // 加载城市数据
    self.cityGroups =  [MTCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    
    // 更改上面挑闪的光标多颜色， 首先要获取searchBar
    self.searchBar.tintColor = MTColor(32, 191, 179);
    

}

- (void)close
{
    // 此处的self。就可以代表整个弹出来的控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma  searchBar的代理
/**
 *  键盘弹出:搜索框开始编辑文字
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // 设置搜索框到背景
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    
    // 设置右边的取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
#warning 为什么此处起不来作用? 按钮的北京色没有改变
    // 显示遮盖 利用UIView创建的动画，然后显示遮盖
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.5 ;
    }];
    
    
    
//    // 设置遮盖
//    UIView *cover = [[UIView alloc] init];
//    cover.backgroundColor = [UIColor blackColor];
//    cover.alpha = 0.5;
//    cover.tag = MTCoverTag;
//    
//    // 添加点击手势
//    // 应该添加点击手势，UITapGestureRecognizer 而不是 UIGestureGecognizer 这样的手势
//    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:searchBar action:@selector(resignFirstResponder)];
//    [cover addGestureRecognizer:tapGesture];
//    // 先把cover加进去View中，然后再进行约束
//    [self.view addSubview:cover];
//    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.tableView.mas_left);
//        make.right.equalTo(self.tableView.mas_right);
//        make.top.equalTo(self.tableView.mas_top);
//        make.bottom.equalTo(self.tableView.mas_bottom);
//    }];
//    

}
//
//- (void)resignFirstResponder
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // 显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    
//    // 隐藏遮盖
//    [[self.view viewWithTag:MTCoverTag] removeFromSuperview];
//    
    // 修改搜索框的背景
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    
    // 关掉取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    
    // 显示遮盖 利用UIView创建的动画，然后显示遮盖
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.0;
    }];
    
    // 5.移除搜索结果
    self.citySearchResult.view.hidden = YES;
    searchBar.text = nil;

    
}

/**
 *  搜索框里面的文字变化的时候调用
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        self.citySearchResult.view.hidden = NO;
        self.citySearchResult.searchText = searchText;
    } else {
        self.citySearchResult.view.hidden = YES;
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)coverClick
{
    [self.searchBar resignFirstResponder];
}

#pragma 数据源和代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 有几个组，就有几个section，
    return self.cityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 一组一个section 先取出一组，然后判断这组有多少行
    MTCityGroup *group = self.cityGroups[section];
    return group.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    // indexPath.section 每个section的cell应该是从零开始的吧，可重用
    MTCityGroup *group = self.cityGroups[indexPath.section];
    cell.textLabel.text = group.cities[indexPath.row];
    
    return cell;
}

#pragma 代理方法
// cell每个section的上面那一块
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MTCityGroup *group = self.cityGroups[section];
    // 再plist中每个group的title就是一个section;
    return group.title;
}

// cell的右边那一块，比如A B C etc.

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//    NSMutableArray *titles = [NSMutableArray array];
//    for (MTCityGroup *group in self.cityGropus) {
//        [titles addObject:group.title];
//    }
//    return titles;
    //  先取到数据， 然后再调用valueforkey 就可以了。
    return [self.cityGroups valueForKey:@"title"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTCityGroup *group = self.cityGroups[indexPath.section];
    // 发出通知
    [MTNotificationCenter postNotificationName:MTCityDidChangeNotification object:nil userInfo:@{MTSelectCityName : group.cities[indexPath.row]}];
    // 点击完城市之后就退下，
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end





//
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

