//
//  SHB_MineVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MineVC.h"
#import "SHB_LonginVC.h"
#import "SHB_BaseNavigationController.h"
#import "SHB_MineInfoCell.h"
#import "SHB_MineOtherCell.h"

@interface SHB_MineVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *signOutBtn;

@end

@implementation SHB_MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    
    UIButton *signOutBtn = [[UIButton alloc] init];
    signOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [signOutBtn setBackgroundColor:[UIColor colorWithHex:@"#2B7650"]];
    [signOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [signOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signOutBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [signOutBtn addTarget:self action:@selector(signOut:) forControlEvents:UIControlEventTouchUpInside];
    self.signOutBtn = signOutBtn;
    [self.view addSubview:signOutBtn];
    
    [signOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.height.equalTo(@50);
    }];
    
}

- (void)signOut:(UIButton *)sender {
    
    UserInfoManager.isLogin = NO;
    [UserInfoManager removeUserInfo];
    
    SHB_LonginVC *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SHB_LonginVC"];
    // 导航控制器
    SHB_BaseNavigationController *nav = [[SHB_BaseNavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 0, 0) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        SHB_MineInfoCell *cell = [SHB_MineInfoCell cellWithTableView:tableView];
//        [cell setModel:nil index:indexPath];
        return cell;
        
    } else {
        
        SHB_MineOtherCell *cell = [SHB_MineOtherCell cellWithTableView:tableView];
//        [cell setModel:nil index:indexPath];
        return cell;
    }
    
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 150;
    } else {
        return 50;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 取消选中
    
}




@end
