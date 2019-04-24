//
//  SHB_PublicCommentVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/4/24.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_PublicCommentVC.h"
#import "SHB_CommentModel.h"

@interface SHB_PublicCommentVC ()

@property (weak, nonatomic) IBOutlet UITextView *commentTV;

@end

@implementation SHB_PublicCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发布留言";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
}


- (IBAction)submitComment:(id)sender {
    
    if (self.commentTV.text.length == 0) {
        ShowMessage(@"评论内容不能为空！");
        return;
    }
    
    [SVProgressHUD showWithStatus:@"提交中..."];
    
    // 3秒后执行以下内容  模拟登陆
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        DismissHud();
        
        SHB_CommentModel *commentModel = [[SHB_CommentModel alloc] init];
        commentModel.content = self.commentTV.text;
        
        [DataBaseManager insertComment:commentModel userId:UserInfoManager.userId];
        
        ShowMessage(@"提交成功");
        
    });
}

@end
