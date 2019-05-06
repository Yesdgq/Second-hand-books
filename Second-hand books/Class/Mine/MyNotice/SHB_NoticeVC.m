//
//  SHB_NoticeVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/5/6.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_NoticeVC.h"
#import "SHB_NoticeCell.h"
#import "SHB_NoticeModel.h"

@interface SHB_NoticeVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;   // 表单
@property (nonatomic, strong) NSMutableArray *dataArray;         // 数据源

@end

@implementation SHB_NoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息公告";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    self.dataArray = [NSMutableArray arrayWithArray:[DataBaseManager queryAllNotices]];
    
    [self addSubviews];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // tableView布局
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
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
    
    SHB_NoticeCell *cell = [SHB_NoticeCell cellWithTableView:tableView];
    SHB_NoticeModel *noticeModel = self.dataArray[indexPath.row];
    cell.noticeModel = noticeModel;
    
    return cell;
    
}

#pragma mark -  UITableViewDataDelegate

// 行高是多少
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

// 将delete改为删除
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    SHB_CommentModel *commentModel = self.dataArray[indexPath.row];
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // 1.把model相应的数据删掉
//        [self.dataArray removeObjectAtIndex:indexPath.row];
//        // 2.把view相应的cell删掉
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        [DataBaseManager deleteCommentWithCommentModel:commentModel];
//    }
//}


@end
