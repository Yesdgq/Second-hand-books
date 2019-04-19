//
//  SHB_LonginVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/18.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_LonginVC.h"
#import "SHB_RegisterVC.h"
#import "SHB_UserModel.h"
#import "AppDelegate.h"


@interface SHB_LonginVC ()

@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;


@end

@implementation SHB_LonginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    self.nickNameTF.text = UserInfoManager.nickname;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


// 去注册
- (IBAction)gotoRegister:(id)sender {
    
    SHB_RegisterVC *registerVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SHB_RegisterVC"];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

// 登录
- (IBAction)login:(id)sender {
    
    if (self.nickNameTF.text.length == 0) {
        ShowMessage(@"昵称不能为空");
        return;
    }
    if (self.passwordTF.text.length == 0) {
        ShowMessage(@"密码不能为空");
        return;
    }
    
    __block SHB_UserModel *userModel = [[SHB_UserModel alloc] init];
    userModel.nickName = self.nickNameTF.text;
    userModel.password = self.passwordTF.text;
    
    [SVProgressHUD showWithStatus:@"登录中..."];
    
    // 3秒后执行以下内容  模拟登陆
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        DismissHud();
        
        if ([self.nickNameTF.text isEqualToString:@"admin"]) {
            
            if ([self.passwordTF.text isEqualToString:@"admin"]) {
                UserInfoManager.isLogin = YES; // 存储登陆状态
                UserInfoManager.nickname = self.nickNameTF.text;
                
                // 初始化Tabbar控件
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate initializeTabbar];
                
            } else {
                ShowMessage(@"用户名或密码错误");
            }
            
        } else {
            
            // 用昵称和密码去数据库查询  返回YES登录成功  返回NO登录失败
            BOOL success = [DataBaseManager whetherLoginSuccessWithUser:userModel];
            
            if (success) {
                
                ShowMessage(@"登录成功");
                
                NSArray *array = [DataBaseManager queryUserWithNickName:userModel.nickName];
                SHB_UserModel *currentUserModel = array.firstObject;
                
                UserInfoManager.isLogin = YES; // 存储登陆状态
                UserInfoManager.userId = currentUserModel.userId;
                UserInfoManager.nickname = currentUserModel.nickName;
                
                // 初始化Tabbar控件
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate initializeTabbar];
                
            } else {
                
                DONG_Log(@"用户名或密码错误");
                ShowMessage(@"用户名或密码错误");
            }
        }
    });
    
}




@end
