//
//  SHB_MyGoodsCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MyGoodsCell.h"

@implementation SHB_MyGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_MyGoodsCell";
    SHB_MyGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setGoodsModel:(SHB_GoodsModel *)goodsModel {
    
//    UIImage *img = [[UIImage alloc] initWithContentsOfFile:goodsModel.coverImage];
//    if (img) {
//        [self.coverIV setImage:img];
//    } else {
//        [self.coverIV setImage:[UIImage imageNamed:@"Book-PlaceHolder"]];
//    }
//
//    self.bookNameLbl.text = goodsModel.bookName;
//    self.authorLbl.text = goodsModel.author;
//    self.priceLbl.text = [NSString stringWithFormat:@"￥%@", goodsModel.price];
//    self.ownerLbl.text = goodsModel.owerID;
//    self.publishLbl.text = goodsModel.publishTime;
    
    _goodsModel = goodsModel;
}

@end
