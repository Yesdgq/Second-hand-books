//
//  SHB_CommentCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/4/24.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_CommentCell.h"


@interface SHB_CommentCell ()

@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;


@end

@implementation SHB_CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_CommentCell";
    SHB_CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setCommentModel:(SHB_CommentModel *)commentModel {
    self.nickNameLbl.text = commentModel.customerNickName;
    self.timeLbl.text = commentModel.creatTime;
    self.commentLbl.text = commentModel.content;
    
    _commentModel = commentModel;
}

@end
