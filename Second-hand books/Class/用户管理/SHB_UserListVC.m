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

@interface SHB_UserListVC ()

@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation SHB_UserListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户管理";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    [self addBarItems];
    
    self.dataArray = [DataBaseManager queryAllUsers];
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

@end
