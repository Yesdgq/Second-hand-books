//
//  SHB_MineInfoSection2Cell.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/22.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHB_UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHB_MineInfoSection2Cell : UITableViewCell

@property (nonatomic, strong) SHB_UserModel *userModel;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
+ (nonnull instancetype)cellWithTableView:(nonnull UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
