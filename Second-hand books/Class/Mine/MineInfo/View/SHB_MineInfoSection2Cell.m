//
//  SHB_MineInfoSection2Cell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/22.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MineInfoSection2Cell.h"

@interface SHB_MineInfoSection2Cell ()

;

@end

@implementation SHB_MineInfoSection2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_MineInfoSection2Cell";
    SHB_MineInfoSection2Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setUserModel:(SHB_UserModel *)userModel {
    
    self.contentTextView.text = userModel.personalProfile;
    
    _userModel = userModel;
}

@end
