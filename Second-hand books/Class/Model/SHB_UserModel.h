//
//  SHB_UserModel.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/18.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHB_UserModel : NSObject

// 以下是用户的属性
@property (nonatomic, copy) NSString *userId;           // 用户ID
@property (nonatomic, copy) NSString *name;             //  姓名
@property (nonatomic, copy) NSString *nickName;         //  昵称
@property (nonatomic, copy) NSString *gender;           //  性别
@property (nonatomic, copy) NSString *mobilePhone;      //  手机
@property (nonatomic, copy) NSString *avatar;           //  头像
@property (nonatomic, copy) NSString *personalProfile;  //  签名短语
@property (nonatomic, copy) NSString *password;         //  密码

@end

NS_ASSUME_NONNULL_END
