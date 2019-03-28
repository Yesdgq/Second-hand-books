//
//  SHB_HomePageCell.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHB_GoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHB_HomePageCell : UITableViewCell

@property (nonatomic, strong) SHB_GoodsModel *goodsModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
