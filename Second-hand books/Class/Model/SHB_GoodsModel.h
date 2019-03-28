//
//  SHB_GoodsModel.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/18.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//  商品的模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHB_GoodsModel : NSObject

// 以下是商品的属性
@property (nonatomic, copy) NSString *bookId;               //  书ID
@property (nonatomic, copy) NSString *bookName;             //  书名
@property (nonatomic, copy) NSString *author;               //  书名
@property (nonatomic, copy) NSString *coverImage;           //  封面图片
@property (nonatomic, copy) NSString *introduction;         //  简介
@property (nonatomic, copy) NSString *price;                //  价钱
@property (nonatomic, copy) NSString *owerID;               //  书籍主人ID
@property (nonatomic, copy) NSString *area;                 //  区域
@property (nonatomic, copy) NSString *publishTime;          //  上线时间
@property (nonatomic, assign) BOOL onShelf;                 //  是否上架

@end

NS_ASSUME_NONNULL_END
