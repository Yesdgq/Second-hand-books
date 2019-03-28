//
//  SHB_HomePageCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_HomePageCell.h"

@interface SHB_HomePageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *authorLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *ownerLbl;
@property (weak, nonatomic) IBOutlet UILabel *publishLbl;


@end

@implementation SHB_HomePageCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_HomePageCell";
    SHB_HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setGoodsModel:(SHB_GoodsModel *)goodsModel {
    
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:goodsModel.coverImage];
    if (img) {
        [self.coverIV setImage:img];
    } else {
        [self.coverIV setImage:[UIImage imageNamed:@"Book-PlaceHolder"]];
    }
    
    self.bookNameLbl.text = goodsModel.bookName;
    self.authorLbl.text = goodsModel.author;
    self.priceLbl.text = [NSString stringWithFormat:@"￥%@", goodsModel.price];
    self.ownerLbl.text = goodsModel.owerID;
    self.publishLbl.text = goodsModel.publishTime;
    
    _goodsModel = goodsModel;
}



@end
