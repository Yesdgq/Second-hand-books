//
//  SHB_BookDetailCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/29.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_BookDetailCell.h"

@interface SHB_BookDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLbl;
@property (weak, nonatomic) IBOutlet UITextView *introductionTV;


@end

@implementation SHB_BookDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_BookDetailCell";
    SHB_BookDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setGoodsModel:(SHB_GoodsModel *)goodsModel {
    
    self.priceLbl.text = [NSString stringWithFormat:@"￥%@", goodsModel.price];
    self.publishTimeLbl.text = goodsModel.publishTime;
    self.introductionTV.text = goodsModel.introduction;
    
    _goodsModel = goodsModel;
}


@end
