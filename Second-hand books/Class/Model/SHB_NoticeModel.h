//
//  SHB_NoticeModel.h
//  Second-hand books
//
//  Created by yesdgq on 2019/5/5.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHB_NoticeModel : NSObject

// 以下是通知的属性

@property (nonatomic, copy) NSString *id;            //  消息ID
@property (nonatomic, copy) NSString *title;            //  消息标题
@property (nonatomic, copy) NSString *content;          //  消息内容
@property (nonatomic, copy) NSString *publisher;        //  发布者名称
@property (nonatomic, copy) NSString *publishTime;      //  发布时间
@property (nonatomic, copy) NSString *userId;           // 发布者的用户ID

@end

NS_ASSUME_NONNULL_END
