//
//  SHB_DiscoveryCell.h
//  Second-hand books
//
//  Created by yesdgq on 2019/4/20.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHB_GoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHB_DiscoveryCell : UICollectionViewCell

@property (nonatomic, strong) SHB_GoodsModel *goodModel;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
