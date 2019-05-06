//
//  SHB_PublishNoticeVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/5/5.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_PublishNoticeVC.h"
#import "SHB_LonginVC.h"
#import "SHB_BaseNavigationController.h"

@interface SHB_PublishNoticeVC ()

@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;

@end

@implementation SHB_PublishNoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 标题
    self.navigationItem.title = @"留言管理";
    // 背景颜色
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    [self addBarItems];
    
}


- (IBAction)publishNotice:(id)sender {
    
    // 非空判断
    if (self.titleTF.text.length == 0) {
        ShowMessage(@"请输入标题");
        return;
    }
    if (self.contentTV.text.length == 0) {
        ShowMessage(@"请输入消息内容");
        return;
    }
    
    // 开始转圈
    [SVProgressHUD showWithStatus:@"发布中..."];
    
    // 3秒后执行以下内容  模拟登陆
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 转圈结束
        DismissHud();
        
        // 初始化一个消息model
        SHB_NoticeModel *noticeModel = [[SHB_NoticeModel alloc] init];
        // 以下为赋值
        noticeModel.title = self.titleTF.text;
        noticeModel.content = self.contentTV.text;
        noticeModel.publisher = @"管理员";
        
        // 把消息存入数据库
        [DataBaseManager insertNotice:noticeModel];
        
        ShowMessage(@"提交成功");
        
    });
    
}

- (void)addBarItems {
    // 初始化按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置按钮位置
    btn.frame = CGRectMake(0, 0, 50, 30);
    // 设置按钮标题
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    // 设置按钮颜色
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    //    btn.backgroundColor = [UIColor redColor];
    // 设置按钮任务
    [btn addTarget:self action:@selector(signout:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
    rightNegativeSpacer.width = -30;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightNegativeSpacer, item, nil];
    
}

// 退出
- (void)signout:(UIButton *)sender {
    UserInfoManager.isLogin = NO;
    [UserInfoManager removeUserInfo];
    
    // 回到登录页面
    SHB_LonginVC *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SHB_LonginVC"];
    // 导航控制器
    SHB_BaseNavigationController *nav = [[SHB_BaseNavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}



@end
