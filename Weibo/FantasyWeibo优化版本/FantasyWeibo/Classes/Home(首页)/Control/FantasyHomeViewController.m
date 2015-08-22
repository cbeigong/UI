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
#import "AFNetworking.h"
#import "FTTitleButton.h"
#import "FTAccountTool.h"
#import "FTUser.h"
#import "MJExtension.h"
#import "FTStatus.h"
#import "UIImageView+WebCache.h"
#import "FTLoadMoreFooter.h"
#import "FTStatusFrame.h"
#import "FTStatusCell.h"
// RGB颜色
#define FantasyColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define FantasyRandomColor FantasyColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));


@interface FantasyHomeViewController () <FTDropdownMenuDelegate>
/**
 *  微博数组（里面放的都是FTStatus模型，一个FTStatus对象就代表一条微博）
 */
@property (nonatomic, strong) NSMutableArray *statuseFrames;

@end

@implementation FantasyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏内容
    [self setupNav];
    
    // 获得用户信息（昵称）
    [self setupUserInfo];
    
    // 集成上啦刷新控件
    [self setupDownRefresh];
    
    // 集成下拉刷新控件
    [self setupUpRefresh];
    
    
    // 获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];


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
//    self.vc = vc;
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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.statuseFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获得cell
    FTStatusCell *cell = [FTStatusCell cellWithTableView:tableView];
    
    // 取出这行对应的微博字典
    FTStatus *status = self.statuseFrames[indexPath.row];
    
//    // 取出这条微博的作者（用户）
//    FTUser *user = status.user;
//    cell.textLabel.text = user.name;
//    
//    // 设置微博的文字
//    cell.detailTextLabel.text = status.text;
//    
//    // 设置头像
//    UIImage *placehoder = [UIImage imageNamed:@"avatar_default_small"];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placehoder];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    FTStatusFrame *frame = self.statuseFrames[indexPath.row];
//    return frame.cellHeight;
//}
/**
 1.将字典转为模型
 2.能够下拉刷新最新的微博数据
 3.能够上拉加载更多的微博数据
 */

- (void)setupNav
{
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* 中间的标题按钮 */
    //    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    FTTitleButton *titleButton = [[FTTitleButton alloc] init];
//    titleButton.width = 150;
//    titleButton.height = 30;
    //    titleButton.backgroundColor = FantasyRandomColor;
    
    // 设置图片和文字
    NSString *name = [FTAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
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
 *  获得用户信息（昵称）
 */
- (void)setupUserInfo
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    FTAccount *account = [FTAccountTool account]; // decode 同时赋值
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        // 设置名字
        FTUser *user = [FTUser objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒中
        account.name = user.name;
        [FTAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];
}


/**
 *  集成刷新控件
 */
- (void)setupDownRefresh
{
    // 1.添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    // 只有用户通过手动下拉刷新，才会触发UIControlEventValueChanged事件
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    // 2.马上进入刷新状态(仅仅是显示刷新状态，并不会触发UIControlEventValueChanged事件)
    [control beginRefreshing];
    
    // 3.马上加载数据
    [self loadNewStatus:control];
}

- (NSMutableArray *)statuseFrames
{
    if (!_statuseFrames) {
        self.statuseFrames = [NSMutableArray array];
    }
    return _statuseFrames;
}

/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
- (void)loadNewStatus:(UIRefreshControl *)control
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    FTAccount *account = [FTAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    FTStatusFrame *firstStatus = [self.statuseFrames firstObject];
    if (firstStatus) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatus.status.idstr;
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [FTStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将 FTStatus数组 转为 FStatusFrame数组
        NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuseFrames insertObjects:newStatuses atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新刷新
        [control endRefreshing];
        
        // 显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
        
        // 结束刷新刷新
        [control endRefreshing];
    }];
}
/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量
 */
- (void)showNewStatusCount:(int)count
{
    // 1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    // 2.设置其他属性
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据", count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    // 3.添加
    label.y = 64 - label.height;
    // 将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 4.动画
    // 先利用1s的时间，让label往下移动一段距离
    CGFloat duration = 1.0; // 动画的时间
    [UIView animateWithDuration:duration animations:^{
        //        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
        CGFloat delay = 1.0; // 延迟1s
        // UIViewAnimationOptionCurveLinear:匀速
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            //            label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    // 如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
}

/**
 *  集成上拉刷新控件
 */
- (void)setupUpRefresh
{
    FTLoadMoreFooter *footer = [FTLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statuseFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    FTAccount *account = [FTAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    FTStatus *lastStatus = [self.statuseFrames lastObject];
    if (lastStatus) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatus.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [FTStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将 FTStatus数组 转为 FTStatusFrame数组
        NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statuseFrames addObjectsFromArray:newFrames];

        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}

/**
 *  获得未读数
 */
- (void)setupUnreadCount
{
    //    HWLog(@"setupUnreadCount");
    //    return;
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    FTAccount *account = [FTAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 微博的未读数
        //        int status = [responseObject[@"status"] intValue];
        // 设置提醒数字
        //        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", status];
        
        // @20 --> @"20"
        // NSNumber --> NSString
        // 设置提醒数字(微博的未读数)
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];
}


/**
 *  将HWStatus模型转为HWStatusFrame模型
 */
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (FTStatus *status in statuses) {
        FTStatusFrame *f = [[FTStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

@end
