//
//  SHB_MineInfoSection0Cell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/22.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MineInfoSection0Cell.h"

@interface SHB_MineInfoSection0Cell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;

@end

@implementation SHB_MineInfoSection0Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:UserInfoManager.avatar];
    if (img) {
        [self.avatarIV setImage:img];
    } else {
        [self.avatarIV setImage:[UIImage imageNamed:@"Avatar"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_MineInfoSection0Cell";
    SHB_MineInfoSection0Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
