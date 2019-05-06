//
//  SHB_DiscoveryVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_DiscoveryVC.h"
#import "SHB_DiscoveryCell.h"
#import "SHB_GoodsModel.h"
#import "SHB_BookDetailInfoVC.h"

@interface SHB_DiscoveryVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SHB_DiscoveryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的购买";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    

    [self addSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    SHB_UserModel *userModel = [[SHB_UserModel alloc] init];
    userModel.userId = UserInfoManager.userId;
    self.dataArray = [DataBaseManager queryBooksBoughtWithUser:userModel];
    [self.collectionView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // tableView布局
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
}

// 添加子视图
- (void)addSubviews {
    [self.view addSubview:self.collectionView];
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 100, 175) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES; // 设置当item较少时仍可以滑动
        _collectionView.backgroundColor = [UIColor whiteColor];
        // 注册cell、sectionHeader、sectionFooter
        [_collectionView registerNib:[UINib nibWithNibName:@"SHB_DiscoveryCell" bundle:nil] forCellWithReuseIdentifier:@"SHB_DiscoveryCell"];
        
    }
    return _collectionView;
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SHB_DiscoveryCell *cell = [SHB_DiscoveryCell cellWithCollectionView:collectionView indexPath:indexPath];
    SHB_GoodsModel *goodModel = self.dataArray[indexPath.row];
    cell.goodModel = goodModel;
    
    return cell;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

/** item Size */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (CGSize){110, 175};
}

/** Section EdgeInsets */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/** item水平间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.f;
}

/** item垂直间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.f;
}

#pragma mark ---- UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 点击某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SHB_GoodsModel *goodsModel = self.dataArray[indexPath.row];
    SHB_BookDetailInfoVC *bookInfoVC = [[SHB_BookDetailInfoVC alloc] init];
    bookInfoVC.goodsModel = goodsModel;
    [self.navigationController pushViewController:bookInfoVC animated:YES];
    
}

@end
