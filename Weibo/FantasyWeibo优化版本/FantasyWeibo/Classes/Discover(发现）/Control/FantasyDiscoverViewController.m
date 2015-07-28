//
//  FantasyDiscoverViewController.m
//  FantasyWeibo
//
//  Created by clm on 15/7/5.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "FantasyDiscoverViewController.h"
#import "UIView+Extension.h"
#import "FTSearchBar.h"

// RGB颜色
#define FantasyColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define FantasyRandomColor FantasyColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));

@interface FantasyDiscoverViewController ()

@end

@implementation FantasyDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//        UISearchBar *searchBar = [[UISearchBar alloc] init];
//        searchBar.height = 30;
//        searchBar.scopeBarBackgroundImage = [UIImage imageNamed:@"searchbar_textfield_background"];
//        self.navigationItem.titleView = searchBar;
    
//    // 创建搜索框对象
//    UITextField *searchBar = [[UITextField alloc] init];
//    searchBar.width = 300;
//    searchBar.height = 30;
//    searchBar.font = [UIFont systemFontOfSize:15];
//    searchBar.placeholder = @"请输入搜索条件";
//    searchBar.background = [UIImage imageNamed:@"searchbar_textfield_background"];
//    
//    // 设置左边的放大镜图标
//    //    UIImage *image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
//    // 通过initWithImage来创建初始化UIImageView，UIImageView的尺寸默认就等于image的尺寸
//    //    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:image];
//    
//    // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
//    UIImageView *searchIcon = [[UIImageView alloc] init];
//    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
//    searchIcon.width = 30;
//    searchIcon.height = 30;
//    searchIcon.contentMode = UIViewContentModeCenter;
//    searchBar.leftView = searchIcon;
//    searchBar.leftViewMode = UITextFieldViewModeAlways;
    FTSearchBar *searchBar = [FTSearchBar searchBar];
    
    // 因为searchBar的大小是在外面设置的，所以封装在里面的话，就不用设置宽度和高度
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
