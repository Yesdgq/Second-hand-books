//
//  SHB_MineInfoCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/21.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MineInfoCell.h"

@interface SHB_MineInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *bioLbl;


@end

@implementation SHB_MineInfoCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:UserInfoManager.avatar];
    if (img) {
        [self.avatarIV setImage:img];
    } else {
        [self.avatarIV setImage:[UIImage imageNamed:@"Avatar"]];
    }
    self.nickNameLbl.text = UserInfoManager.nickname;
    self.nameLbl.text = UserInfoManager.name;
    self.phoneLbl.text = UserInfoManager.mobilePhone;
    self.bioLbl.text = UserInfoManager.personalProfile;
    
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
