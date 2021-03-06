//
//  SHB_MineInfoSection1Cell.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/22.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHB_MineInfoSection1Cell : UITableViewCell

@property (weak, nonatomic, readonly) UITextField *contentTF;

+ (nonnull instancetype)cellWithTableView:(nonnull UITableView *)tableView;
- (void)setModel:(nullable id)model index:(nullable NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
