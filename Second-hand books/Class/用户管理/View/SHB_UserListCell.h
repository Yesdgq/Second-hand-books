//
//  SHB_UserListCell.h
//  Second-hand books
//
//  Created by yesdgq on 2019/4/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHB_UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHB_UserListCell : UITableViewCell

@property (nonatomic, strong) SHB_UserModel *userModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
