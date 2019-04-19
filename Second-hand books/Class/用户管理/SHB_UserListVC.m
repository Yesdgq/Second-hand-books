//
//  SHB_UserListVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/4/18.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_UserListVC.h"
#import "SHB_LonginVC.h"
#import "SHB_BaseNavigationController.h"
#import "SHB_UserListCell.h"

@interface SHB_UserListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;   // 表单

@end

@implementation SHB_UserListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户管理";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    [self addBarItems];
    
    self.dataArray = [NSMutableArray arrayWithArray:[DataBaseManager queryAllUsers]];
    [self addSubviews];
}

- (void)addBarItems {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    //    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(signout:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
    rightNegativeSpacer.width = -30;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightNegativeSpacer, item, nil];
    
}

- (void)signout:(UIButton *)sender {
    UserInfoManager.isLogin = NO;
    [UserInfoManager removeUserInfo];
    
    SHB_LonginVC *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SHB_LonginVC"];
    // 导航控制器
    SHB_BaseNavigationController *nav = [[SHB_BaseNavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

// 添加子视图
- (void)addSubviews {
    
    // 初始化tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //        _tableView.scrollEnabled = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:self.tableView]; // 添加到页面
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // tableView布局
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource

// 有几个分区
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 1;
}

// 每个分区后多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SHB_UserListCell *cell = [SHB_UserListCell cellWithTableView:tableView];
    SHB_UserModel *userModel = self.dataArray[indexPath.row];
    cell.userModel = userModel;
    
    return cell;
    
}

#pragma mark -  UITableViewDataDelegate

// 行高是多少
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

// 将delete改为删除
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    SHB_UserModel *userModel = self.dataArray[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 1.把model相应的数据删掉
        [self.dataArray removeObjectAtIndex:indexPath.row];
        // 2.把view相应的cell删掉
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        [DataBaseManager deleteUserWihtUserModel:userModel];
    }
}




@end
