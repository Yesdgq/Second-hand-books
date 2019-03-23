//
//  SHB_MineInfoVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/22.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MineInfoVC.h"
#import "SHB_MineInfoSection0Cell.h"
#import "SHB_MineInfoSection1Cell.h"
#import "SHB_MineInfoSection2Cell.h"

@interface SHB_MineInfoVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation SHB_MineInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人信息";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
        
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [submitButton setTitle:@"保存修改" forState:UIControlStateNormal];
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [submitButton setBackgroundColor:[UIColor colorWithHex:@"#2B7650"]];
        [submitButton addTarget:self action:@selector(submitChanges) forControlEvents:UIControlEventTouchUpInside];
        self.submitButton = submitButton;
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
        [footerView addSubview:submitButton];
        [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footerView.mas_left).offset(60);
            make.right.equalTo(footerView.mas_right).offset(-60);
            make.centerY.equalTo(footerView.mas_centerY);
            make.height.equalTo(@50);
        }];
        _tableView.tableFooterView = footerView;
        
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SHB_MineInfoSection0Cell *cell = [SHB_MineInfoSection0Cell cellWithTableView:tableView];
//        [cell setModel:_avatarImage index:indexPath];
        return cell;
        
    } else if (indexPath.section == 1) {
        SHB_MineInfoSection1Cell *cell = [SHB_MineInfoSection1Cell cellWithTableView:tableView];
        [cell setModel:nil index:indexPath];
        return cell;
    } else {
        SHB_MineInfoSection2Cell *cell = [SHB_MineInfoSection2Cell cellWithTableView:tableView];
//        [cell setModel:nil index:indexPath];
//        cell.callback = ^(UITextView *textView) {
//            _bioString = textView.text;
//        };
        return cell;
    }
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 118;
    } else if (indexPath.section ==1) {
        return 45;
    } else {
        return 145;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 0;
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 取消选中
    if (indexPath.section == 0) {
        
       
        
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
               
            }
                break;
                
            case 1:
                
                break;
                
            case 2:
            {
               
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)submitChanges {
    
}


@end
