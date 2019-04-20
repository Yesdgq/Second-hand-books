//
//  SHB_MineOtherCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/21.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MineOtherCell.h"

@interface SHB_MineOtherCell ()

@property (weak, nonatomic) IBOutlet UIImageView *leftIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end

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

- (void)setModel:(nullable id)model index:(nullable NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            [self.leftIV setImage:[UIImage imageNamed:@"About"]];
            self.titleLbl.text = @"关于";
            
        } else if (indexPath.row == 1) {
            
            [self.leftIV setImage:[UIImage imageNamed:@"Update"]];
            self.titleLbl.text = @"更新";
        }
        
    } else  if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            [self.leftIV setImage:[UIImage imageNamed:@"NoDistrub"]];
            self.titleLbl.text = @"我的发布";
            
        } else if (indexPath.row == 1) {
            
            [self.leftIV setImage:[UIImage imageNamed:@"Share"]];
            self.titleLbl.text = @"我的购买";
            
        }
    }
    
}


@end
