//
//  SHB_NoticeCell.m
//  Second-hand books
//
//  Created by yesdgq on 2019/5/6.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_NoticeCell.h"

@interface SHB_NoticeCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *publishInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *noticeContentLbl;

@end

@implementation SHB_NoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SHB_NoticeCell";
    SHB_NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil][0];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setNoticeModel:(SHB_NoticeModel *)noticeModel {
    self.titleLbl.text = noticeModel.title;
    self.publishInfoLbl.text = [NSString stringWithFormat:@"发布者：%@  发布时间：%@", noticeModel.publisher, noticeModel.publishTime];
    self.noticeContentLbl.text = noticeModel.content;
    
    _noticeModel = noticeModel;
}

@end
