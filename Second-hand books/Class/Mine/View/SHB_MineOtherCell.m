//
//  SHB_MineOtherCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/21.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MineOtherCell.h"

@implementation SHB_MineOtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_MineOtherCell";
    SHB_MineOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];

    
    return cell;
}

@end
