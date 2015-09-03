//
//  MTHomeViewController.m
//  美团HD
//
//  Created by clm on 15/8/17.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTHomeViewController.h"
#import "MTConst.h"
#import "MTNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "MTHomeTopItem.h"
#import "MTHomeDropdown.h"
#import "MTCategoryViewController.h"
#import "MTHomeDropdown.h"
#import "MTRegionViewController.h"
#import "MTSortViewController.h"
#import "MTSort.h"
#import "MTCategory.h"
#import "MTRegion.h"
#import "MTMetaTool.h"
#import "MTCity.h"
#import "MBProgressHUD+MJ.h"
#import "MJRefresh.h"
#import "UIView+AutoLayout.h"
#import "AwesomeMenu.h"
#import "MTCollectViewController.h"
#import "MTRecentViewController.h"
#import "MTSearchViewController.h"
#import "MTMapViewController.h"

@interface MTHomeViewController ()
@property   (nonatomic, weak) UIBarButtonItem *categoryItem;
@property   (nonatomic, weak) UIBarButtonItem *regionItem;
@property   (nonatomic, weak) UIBarButtonItem *sortItem;

/** 当前选中的城市名字 */
@property (nonatomic, copy) NSString *selectedCityName;
/** 当前选中的分类名字 */
@property (nonatomic, copy) NSString *selectedCategoryName;
/** 当前选中的区域名字 */
@property (nonatomic, copy) NSString *selectedRegionName;
/** 当前选中的排序 */
@property (nonatomic, strong) MTSort *selectedSort;

/** 分类popover */
@property (nonatomic, strong) UIPopoverController *categoryPopover;
/** 区域popover */
@property (nonatomic, strong) UIPopoverController *regionPopover;
/** 排序popover */
@property (nonatomic, strong) UIPopoverController *sortPopover;

@end

@implementation MTHomeViewController

//static NSString * const reuseIdentifier = @"Cell";
//
//- (instancetype)init
//{
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    return [self initWithCollectionViewLayout:layout];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    // self.view = self.tableView;
    // self.view = self.collectionView.superView;
//    self.collectionView.backgroundColor = MTGlobalBg;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self setupLeftNav];
    [self setupRightNav];
    
    //测试为什么加上去这个后会发生过坏内存访问， 我的解决方法是去掉autolayout和sizeclass然后 去一个地方把长宽都去掉，上下左右的线都加。就行了。
//    [self.view addSubview:[MTHomeDropdown dropdown]];
    
    // 创建awesomemenu
    [self setupAwesomeMenu];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MTNotificationCenter removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNotifications];
}
- (void)setupAwesomeMenu
{
    // 1.中间的item
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"] highlightedContentImage:nil];
    
    // 2.周边的item
    AwesomeMenuItem *item0 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    AwesomeMenuItem *item1 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    AwesomeMenuItem *item2 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    AwesomeMenuItem *item3 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    
    NSArray *items = @[item0, item1, item2, item3];
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectZero startItem:startItem optionMenus:items];
    menu.alpha = 0.5;
    // 设置菜单的活动范围
    menu.menuWholeAngle = M_PI_2;
    // 设置开始按钮的位置
    menu.startPoint = CGPointMake(50, 150);
    // 设置代理
    menu.delegate = self;
    // 不要旋转中间按钮
    menu.rotateAddButton = NO;
    [self.view addSubview:menu];
    
    // 设置菜单永远在左下角
    [menu autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [menu autoSetDimensionsToSize:CGSizeMake(200, 200)];
}

#pragma mark - AwesomeMenuDelegate
- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu
{
    // 替换菜单的图片
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    
    // 完全显示
    menu.alpha = 1.0;
}

- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu
{
    // 替换菜单的图片
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    
    // 半透明显示
    menu.alpha = 0.5;
}

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    // 半透明显示
    menu.alpha = 0.5;
    
    // 替换菜单的图片
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    
    switch (idx) {
        case 0: { // 收藏
            MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:[[MTCollectViewController alloc] init]];
            [self presentViewController:nav animated:YES completion:nil];
            break;
        }
            
        case 1: { // 最近访问记录
            MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:[[MTRecentViewController alloc] init]];
            [self presentViewController:nav animated:YES completion:nil];
            break;
        }
            
        default:
            break;
    }
}


- (void)setupNotifications
{
    // 监听城市改变
    [MTNotificationCenter addObserver:self selector:@selector(cityDidChange:) name:MTCityDidChangeNotification object:nil];
    // 监听排序改变
    [MTNotificationCenter addObserver:self selector:@selector(sortDidChange:) name:MTSortDidChangeNotification object:nil];
    // 监听分类改变
    [MTNotificationCenter addObserver:self selector:@selector(categoryDidChange:) name:MTCategoryDidChangeNotification object:nil];
    // 监听区域改变
    [MTNotificationCenter addObserver:self selector:@selector(regionDidChange:) name:MTRegionDidChangeNotification object:nil];
}


#pragma mark - 监听通知
- (void)cityDidChange:(NSNotification *)notification
{
    // 从通知的key中获取得到的城市名字
    self.selectedCityName = notification.userInfo[MTSelectCityName];
    
    // 1.更换顶部区域item的文字 为了有提示，所以就进行强转
    MTHomeTopItem *topItem = (MTHomeTopItem *)self.regionItem.customView;
    [topItem setTitle:[NSString stringWithFormat:@"%@ - 全部", self.selectedCityName]];
    [topItem setSubtitle:nil];
//    
//    // 2.刷新表格数据
    [self.collectionView headerBeginRefreshing];
}

- (void)categoryDidChange:(NSNotification *)notification
{
    MTCategory *category = notification.userInfo[MTSelectCategory];
    NSString *subcategoryName = notification.userInfo[MTSelectSubcategoryName];
    
    if (subcategoryName == nil || [subcategoryName isEqualToString:@"全部"]) { // 点击的数据没有子分类
        self.selectedCategoryName = category.name;
    } else {
        self.selectedCategoryName = subcategoryName;
    }
    if ([self.selectedCategoryName isEqualToString:@"全部分类"]) {
        self.selectedCategoryName = nil;
    }
    
    // 1.更换顶部item的文字
    MTHomeTopItem *topItem = (MTHomeTopItem *)self.categoryItem.customView;
    [topItem setIcon:category.icon highIcon:category.highlighted_icon];
    [topItem setTitle:category.name];
    [topItem setSubtitle:subcategoryName];
    
    // 2.关闭popover
    [self.categoryPopover dismissPopoverAnimated:YES];
//    
//    // 3.刷新表格数据
    [self.collectionView headerBeginRefreshing];
}

- (void)regionDidChange:(NSNotification *)notification
{
    MTRegion *region = notification.userInfo[MTSelectRegion];
    NSString *subregionName = notification.userInfo[MTSelectSubregionName];
    
    if (subregionName == nil || [subregionName isEqualToString:@"全部"]) {
        self.selectedRegionName = region.name;
    } else {
        self.selectedRegionName = subregionName;
    }
    if ([self.selectedRegionName isEqualToString:@"全部"]) {
        self.selectedRegionName = nil;
    }
    
    // 1.更换顶部item的文字
    MTHomeTopItem *topItem = (MTHomeTopItem *)self.regionItem.customView;
    [topItem setTitle:[NSString stringWithFormat:@"%@ - %@", self.selectedCityName, region.name]];
    [topItem setSubtitle:subregionName];
    
    // 2.关闭popover
    [self.regionPopover dismissPopoverAnimated:YES];
//    
//    // 3.刷新表格数据
    [self.collectionView headerBeginRefreshing];
}

- (void)sortDidChange:(NSNotification *)notification
{
    // 监听通知， 拿到数据，然后设置topItem的标题
    self.selectedSort = notification.userInfo[MTSelectSort];
    
    // 1.更换顶部排序item的文字
    MTHomeTopItem *topItem = (MTHomeTopItem *)self.sortItem.customView;
    [topItem setSubtitle:self.selectedSort.label];
    
    // 2.关闭popover
    [self.sortPopover dismissPopoverAnimated:YES];
//    
//    // 3.刷新表格数据
    [self.collectionView headerBeginRefreshing];
}



// 设置导航栏左边的内容
- (void)setupLeftNav
{
    UIBarButtonItem *logoItem = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_meituan_logo" highImage:@"icon_meituan_logo_highlighted"];
    logoItem.enabled = NO;
    
    // 设置类别
    MTHomeTopItem *categoryTopItem = [MTHomeTopItem item];
    [categoryTopItem addTarget:self action:@selector(categoryClick)];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryTopItem];
    self.categoryItem = categoryItem;
    
    // 设置地区
    MTHomeTopItem *regionTopItem = [MTHomeTopItem item];
    [regionTopItem addTarget:self action:@selector(regionClick)];
    UIBarButtonItem *regionItem = [[UIBarButtonItem alloc] initWithCustomView:regionTopItem];
    self.regionItem = regionItem;
    
    //设置排序
    MTHomeTopItem *sortTopItem = [MTHomeTopItem item];
    [sortTopItem setTitle:@"排序"];
    [sortTopItem setIcon:@"icon_sort" highIcon:@"icon_sort_highlighted"];
    [sortTopItem addTarget:self action:@selector(sortClick)];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortTopItem];
    self.sortItem = sortItem;
    
    
    self.navigationItem.leftBarButtonItems = @[logoItem, categoryItem, regionItem, sortItem];
}
#pragma 监听顶部Item的点击事件
- (void)categoryClick
{
    self.categoryPopover = [[UIPopoverController alloc] initWithContentViewController:[[MTCategoryViewController alloc] init]];
    
    [self.categoryPopover presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }

- (void)regionClick
{
    MTRegionViewController *region = [[MTRegionViewController alloc] init];
#warning if里面的判断不要写错
    // 我在把self.selectedCityName 这个东西写成 self.selectedCityName 使得数据regions一直都没有传数据进去
    if (self.selectedCityName) {
        // 把regions 传进去所选的城市
        // 第二次点击或者第三次点击就做这些事情
        MTCity *city = [[[MTMetaTool cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@", self.selectedCityName]] firstObject];
        region.regions = city.regions;
    }
    // 显示区域菜单
    self.regionPopover = [[UIPopoverController alloc] initWithContentViewController:region];
    
    [self.regionPopover presentPopoverFromBarButtonItem:self.regionItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    // 把控制器传给region 里买的控制器
    region.popover = self.regionPopover;
    
}

- (void)sortClick
{
    self.sortPopover = [[UIPopoverController alloc] initWithContentViewController:[[MTSortViewController alloc] init]];
    [self.sortPopover presentPopoverFromBarButtonItem:self.sortItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
          
// 设置导航栏右边的内容
- (void)setupRightNav
{
    UIBarButtonItem *mapItem = [UIBarButtonItem itemWithTarget:self action:@selector(map) image:@"icon_map" highImage:@"icon_map_highlighted"];
    
//    map.width = 60;
    mapItem.customView.width = 60;
    
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"icon_search" highImage:@"icon_search_hightlighted"];
    searchItem.customView.width = 60;
    
    self.navigationItem.rightBarButtonItems = @[mapItem, searchItem];
}

- (void)map
{
    MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:[[MTMapViewController alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)search
{

    if (self.selectedCityName) {
        MTSearchViewController *searchVc = [[MTSearchViewController alloc] init];
        searchVc.cityName = self.selectedCityName;
        MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:searchVc];
        [self presentViewController:nav animated:YES completion:nil];
    } else {
        [MBProgressHUD showError:@"请选择城市后再搜索" toView:self.view];
    }
}

#pragma mark - 实现父类提供的方法
- (void)setupParams:(NSMutableDictionary *)params
{
    // 城市
    if (self.selectedCityName) {
        params[@"city"] = self.selectedCityName;
    }
    // 分类(类别)
    if (self.selectedCategoryName) {
        params[@"category"] = self.selectedCategoryName;
    }
    // 区域
    if (self.selectedRegionName) {
        params[@"region"] = self.selectedRegionName;
    }
    // 排序
    if (self.selectedSort) {
        params[@"sort"] = @(self.selectedSort.value);
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//#pragma mark <UICollectionViewDataSource>
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
//    return 0;
//}
//
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete method implementation -- Return the number of items in the section
//    return 0;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell
//    
//    return cell;
//}
//
//#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
