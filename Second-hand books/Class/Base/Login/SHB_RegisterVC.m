//
//  SHB_RegisterVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/18.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//  注册

#import "SHB_RegisterVC.h"
#import "SHB_UserModel.h"

@interface SHB_RegisterVC ()

@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;


@end

@implementation SHB_RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    
}


// 提交注册
- (IBAction)registerAccount:(id)sender {
    
    if (![self.passwordTF.text isEqualToString:self.confirmPasswordTF.text]) {
        ShowMessage(@"两次输入的密码不一致");
        return;
    }
    
    SHB_UserModel *userModel = [[SHB_UserModel alloc] init];
    userModel.nickName = self.nickNameTF.text;
    userModel.name = self.nameTF.text;
    userModel.password = self.passwordTF.text;
    
    BOOL success = [DataBaseManager insertUser:userModel];
    
    
    
    [SVProgressHUD showWithStatus:@"注册中..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        DismissHud();
        
        if (success) {
            ShowMessage(@"注册成功！");
            [self.navigationController popViewControllerAnimated:YES];
        }
    });
    
}


@end
