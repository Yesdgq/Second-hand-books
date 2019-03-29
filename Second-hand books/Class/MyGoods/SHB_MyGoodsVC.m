//
//  SHB_MyGoodsVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MyGoodsVC.h"
#import "SHB_MyGoodsCell.h"
#import "SHB_PublishBookVC.h"

@interface SHB_MyGoodsVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;   // 表单
@property (nonatomic, strong) NSMutableArray *dataArray;         // 数据源

@end

@implementation SHB_MyGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的发布";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    [self addBarItems];
    
    
    [self addSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 查询指定人的全部书
    self.dataArray = [[DataBaseManager queryAllBooksWithUserId:UserInfoManager.userId] mutableCopy];
    [self.tableView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // tableView布局
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)addBarItems {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setImage:[UIImage imageNamed:@"More"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(publishGoods:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
    rightNegativeSpacer.width = -25;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightNegativeSpacer,item, nil];
    
}

- (void)publishGoods:(UIButton *)sender {
    
    SHB_PublishBookVC *publishVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SHB_PublishBookVC"];
    [self.navigationController pushViewController:publishVC animated:YES];
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
    
    SHB_MyGoodsCell *cell = [SHB_MyGoodsCell cellWithTableView:tableView];
    SHB_GoodsModel *goodsModel = self.dataArray[indexPath.row];
    cell.goodsModel = goodsModel;
    
    return cell;
    
}

#pragma mark -  UITableViewDataDelegate

// 行高是多少
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

// 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 取消选中
    
    //    SHB_BookDetailInfoVC *bookInfoVC = [[SHB_BookDetailInfoVC alloc] init];
    //    [self.navigationController pushViewController:bookInfoVC animated:YES];
}

//// 将delete改为删除
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"删除";
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    SHB_GoodsModel *goodsModel = self.dataArray[indexPath.row];
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // 1.把model相应的数据删掉
//        [self.dataArray removeObjectAtIndex:indexPath.row];
//        // 2.把view相应的cell删掉
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//        [DataBaseManager deleteGoodsWithGoodsModel:goodsModel];
//    }
//}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        // 1.把model相应的数据删掉
        SHB_GoodsModel *goodsModel = self.dataArray[indexPath.row];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        // 2.把view相应的cell删掉
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [DataBaseManager deleteGoodsWithGoodsModel:goodsModel];
        [tableView setEditing:NO animated:YES];
    }];
    action0.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"上架" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        SHB_GoodsModel *goodsModel = self.dataArray[indexPath.row];
        goodsModel.onShelf = YES;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [DataBaseManager updateBook:goodsModel];
        [tableView setEditing:NO animated:YES];
    }];
    action1.backgroundColor = [UIColor greenColor];
    
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"下架" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        SHB_GoodsModel *goodsModel = self.dataArray[indexPath.row];
        goodsModel.onShelf = NO;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [DataBaseManager updateBook:goodsModel];
        [tableView setEditing:NO animated:YES];
        
    }];
    
    action2.backgroundColor = [UIColor blueColor];
    return @[action0, action1, action2];
}




@end
