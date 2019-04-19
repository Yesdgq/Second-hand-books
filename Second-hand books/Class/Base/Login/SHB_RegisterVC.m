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
@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneTF;


@end

@implementation SHB_RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户注册";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
}


// 提交注册
- (IBAction)registerAccount:(id)sender {
    
    if (self.nickNameTF.text.length == 0) {
        ShowMessage(@"昵称不能为空");
        return;
    }
    
    if (self.passwordTF.text.length == 0) {
        ShowMessage(@"请输入密码");
        return;
    }
    if (self.confirmPasswordTF.text.length == 0) {
        ShowMessage(@"请输入确认密码");
        return;
    }
    
    if (![self.passwordTF.text isEqualToString:self.confirmPasswordTF.text]) {
        ShowMessage(@"两次输入的密码不一致");
        return;
    }
    
    SHB_UserModel *userModel = [[SHB_UserModel alloc] init];
    userModel.nickName = self.nickNameTF.text;
    userModel.name = self.nameTF.text;
    userModel.password = self.passwordTF.text;
    userModel.mobilePhone = self.mobilePhoneTF.text;
    
    
    
    
    [SVProgressHUD showWithStatus:@"注册中..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        DismissHud();
        
        if ([self.nickNameTF.text isEqualToString:@"admin"]) {
            ShowMessage(@"不能使用改昵称！");
            return;
        }
        
        BOOL isExisted = [DataBaseManager queryUserIsExistedWithNickName:userModel];
        
        if (isExisted) {
            
            ShowMessage(@"用户已存在，请换个昵称试试！");
            return;
        }
        
        
         BOOL success  = [DataBaseManager insertUser:userModel];
        
        
        
        if (success) {
            ShowMessage(@"注册成功！");
            [self.navigationController popViewControllerAnimated:YES];
        }
    });
    
}


@end
