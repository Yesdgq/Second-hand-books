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
    
    SHB_UserModel *userModel = [[SHB_UserModel alloc] init];
    userModel.nickName = self.nickNameTF.text;
    userModel.password = self.passwordTF.text;
    
    BOOL hasUser = [DataBaseManager queryUserIsExisted:userModel];
    
    [SVProgressHUD showWithStatus:@"登录中..."];
    
    // 2秒后执行以下内容  模拟登陆
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        DismissHud();
        
        if (hasUser) {
            
            ShowMessage(@"登录成功");
            UserInfoManager.isLogin = YES; // 存储登陆状态
            UserInfoManager.name = userModel.name;
            UserInfoManager.nickname = userModel.nickName;
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate initializeTabbar];
            
        } else {
            
            DONG_Log(@"用户名或密码错误");
            ShowMessage(@"用户名或密码错误");
        }
    });
    
}




@end