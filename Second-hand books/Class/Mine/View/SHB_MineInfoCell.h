//
//  SHB_MineInfoCell.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/21.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHB_UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHB_MineInfoCell : UITableViewCell

@property (nonatomic, strong) SHB_UserModel *userModel;

+ (nonnull instancetype)cellWithTableView:(nonnull UITableView *)tableView;
- (void)setModel:(nullable id)model index:(nullable NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
