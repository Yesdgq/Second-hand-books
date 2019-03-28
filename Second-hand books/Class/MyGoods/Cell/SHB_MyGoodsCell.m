//
//  SHB_MyGoodsCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MyGoodsCell.h"


@interface SHB_MyGoodsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *shelfStatusLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLbl;


@end

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
    
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:goodsModel.coverImage];
    if (img) {
        [self.coverIV setImage:img];
    } else {
        [self.coverIV setImage:[UIImage imageNamed:@"Book-PlaceHolder"]];
    }

    self.bookNameLbl.text = goodsModel.bookName;
    NSString *shelfStatusStr;
    if (goodsModel.onShelf) {
        shelfStatusStr = @"销售中";
    } else {
        shelfStatusStr = @"下架";
    }
    self.shelfStatusLbl.text = shelfStatusStr;
    self.priceLbl.text = [NSString stringWithFormat:@"￥%@", goodsModel.price];
    self.publishTimeLbl.text = goodsModel.publishTime;
    
    _goodsModel = goodsModel;
}

@end
