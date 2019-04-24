//
//  SHB_CommentCell.h
//  Second-hand books
//
//  Created by yesdgq on 2019/4/24.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHB_CommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHB_CommentCell : UITableViewCell

@property (nonatomic, strong) SHB_CommentModel *commentModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
