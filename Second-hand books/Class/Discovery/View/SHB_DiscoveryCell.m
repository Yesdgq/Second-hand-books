//
//  SHB_DiscoveryCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/4/20.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_DiscoveryCell.h"

@interface SHB_DiscoveryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLbl;

@end

@implementation SHB_DiscoveryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    static NSString *ID;
    ID = @"SHB_DiscoveryCell";
    
    SHB_DiscoveryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    return cell;
}

- (void)setGoodModel:(SHB_GoodsModel *)goodModel {
    
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:goodModel.coverImage];
    if (img) {
        [self.coverIV setImage:img];
    } else {
        [self.coverIV setImage:[UIImage imageNamed:@"Book-PlaceHolder"]];
    }
    self.bookNameLbl.text = goodModel.bookName;
}

@end
