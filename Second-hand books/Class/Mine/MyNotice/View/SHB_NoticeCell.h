//
//  SHB_NoticeCell.h
//  Second-hand books
//
//  Created by yesdgq on 2019/5/6.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHB_NoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHB_NoticeCell : UITableViewCell

@property (nonatomic, strong) SHB_NoticeModel *noticeModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
