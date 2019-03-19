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

@interface SHB_MineVC ()

@property (nonatomic, strong) UIButton *signOutBtn;

@end

@implementation SHB_MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    
    
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




@end
