//
//  SHB_MineInfoSection1Cell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/22.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MineInfoSection1Cell.h"

@interface SHB_MineInfoSection1Cell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;

@end

@implementation SHB_MineInfoSection1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_MineInfoSection1Cell";
    SHB_MineInfoSection1Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setModel:(nullable id)model index:(nullable NSIndexPath *)indexPath {
    SHB_UserModel *userModel = (SHB_UserModel *)model;
    
    self.contentTF.tag = indexPath.row; // 给输入框做tag标记
    
    if (indexPath.row == 0) {
        self.titleLbl.text = @"昵称";
        self.contentTF.text = userModel.nickName;
        
    } else if (indexPath.row == 1) {
        self.titleLbl.text = @"姓名";
        self.contentTF.text = userModel.name;
        
    } else if (indexPath.row == 2) {
        self.titleLbl.text = @"电话";
        self.contentTF.text = userModel.mobilePhone;
    }
}

@end
