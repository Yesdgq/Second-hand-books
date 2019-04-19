//
//  SHB_BookListCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/4/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_BookListCell.h"

@interface SHB_BookListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *shelfStatusLbl;
@property (weak, nonatomic) IBOutlet UILabel *bookOwerLbl;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLbl;


@end

@implementation SHB_BookListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_BookListCell";
    SHB_BookListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
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
    self.bookOwerLbl.text = goodsModel.owerID;
    self.publishTimeLbl.text = goodsModel.publishTime;

    _goodsModel = goodsModel;
}

@end
