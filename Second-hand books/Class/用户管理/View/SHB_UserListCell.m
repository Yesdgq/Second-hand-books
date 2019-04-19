//
//  SHB_UserListCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/4/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_UserListCell.h"

@interface SHB_UserListCell ()

@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *registTimeLbl;

@end

@implementation SHB_UserListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_UserListCell";
    SHB_UserListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setUserModel:(SHB_UserModel *)userModel {
    self.nickNameLbl.text = userModel.nickName;
    self.nameLbl.text = userModel.name;
    self.phoneLbl.text = userModel.mobilePhone;
    self.registTimeLbl.text = @"";
}

@end
