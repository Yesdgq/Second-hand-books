//
//  SHB_BookDetailInfoVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_BookDetailInfoVC.h"
#import "SHB_GoodsModel.h"
#import "SHB_BookDetailCell.h"

static const CGFloat kDefaultHeadHeight = (215.f);
static const CGFloat kContentIndent = 0.f;

@interface SHB_BookDetailInfoVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;   // 表单
@property(nonatomic, strong) UIImageView *headImageView;

@end

@implementation SHB_BookDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"图书详情";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    [self addSubviews];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    
}

// 添加子视图
- (void)addSubviews {
    
    // 底部背景
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:self.goodsModel.coverImage];
    if (img) {
        [self.headImageView setImage:img];
    } else {
        [self.headImageView setImage:[UIImage imageNamed:@"Book-PlaceHolder"]];
    }
    [self.view addSubview:self.headImageView];
    [self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kDefaultHeadHeight));
        
    }];
    
    // 初始化tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //        _tableView.scrollEnabled = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    UIView *tableHeadBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, kDefaultHeadHeight)];
    tableHeadBgView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = tableHeadBgView;
    
    [self.view addSubview:self.tableView]; // 添加到页面
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    // 书名
    UILabel *bookNameLbl = [[UILabel alloc] init];
    bookNameLbl.text = [NSString stringWithFormat:@"《%@》",  self.goodsModel.bookName];
    bookNameLbl.textColor = [UIColor whiteColor];
    bookNameLbl.font = [UIFont systemFontOfSize:22.f];
    bookNameLbl.textAlignment = NSTextAlignmentLeft;
    [self.tableView.tableHeaderView addSubview:bookNameLbl];
    [bookNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.tableHeaderView.mas_top).offset(40);
        make.left.equalTo(self.tableView.tableHeaderView.mas_left).offset(20);
        make.height.equalTo(@40);
    }];
    
    // 购买按钮
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setTitle:@"购买" forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.backgroundColor = [UIColor colorWithHex:@"#2B7A52"];
    [buyBtn addTarget:self action:@selector(buyTheBook:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView.tableHeaderView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tableView.tableHeaderView.mas_bottom).offset(-15);
        make.right.equalTo(self.tableView.tableHeaderView.mas_right).offset(-20);
        make.height.equalTo(@30);
        make.width.equalTo(@(80));
    }];
}

// 买书
- (void)buyTheBook:(UIButton *)sender {
    [SVProgressHUD showWithStatus:@"提交中..."];
    
    // 3秒后执行以下内容  模拟登陆
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DismissHud();
        [DataBaseManager insertBook:self.goodsModel userId:UserInfoManager.userId];
        ShowMessage(@"购买成功");
    });
    
}

#pragma mark - UITableViewDataSource

// 有几个分区
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 1;
}

// 每个分区后多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SHB_BookDetailCell *cell = [SHB_BookDetailCell cellWithTableView:tableView];
    cell.goodsModel = self.goodsModel;
    
    return cell;
    
}

#pragma mark -  UITableViewDataDelegate

// 行高是多少
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UIScreen mainScreen].bounds.size.height - kDefaultHeadHeight - 64;
}

// 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 取消选中
    
    SHB_BookDetailInfoVC *bookInfoVC = [[SHB_BookDetailInfoVC alloc] init];
    [self.navigationController pushViewController:bookInfoVC animated:YES];
}

# pragma mark- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < 0.f) {
        [self setHeadImageViewConstraints:kDefaultHeadHeight - scrollView.contentOffset.y originalY:kContentIndent];
        
    } else {
        [self setHeadImageViewConstraints:kDefaultHeadHeight originalY:(0.f - scrollView.contentOffset.y) + kContentIndent];
    }
    
}

- (void)setHeadImageViewConstraints:(CGFloat)height originalY:(CGFloat)y {
    
    [self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(y + 64);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(height));
    }];
}

#pragma mark - Getter

- (UIImageView *)headImageView{
    if (!_headImageView) {
        UIImageView *headImageView = [[UIImageView alloc] init];
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        headImageView.clipsToBounds = YES;
        _headImageView = headImageView;
    }
    return _headImageView;
}



@end
