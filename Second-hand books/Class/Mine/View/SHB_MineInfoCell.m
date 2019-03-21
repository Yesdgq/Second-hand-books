//
//  SHB_MineInfoCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/21.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MineInfoCell.h"

@implementation SHB_MineInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_MineInfoCell";
    SHB_MineInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
