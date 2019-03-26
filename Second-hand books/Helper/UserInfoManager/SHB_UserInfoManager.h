//
//  SHB_UserInfoManager.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/17.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHB_UserInfoManager : NSObject

#define UserInfoManager [SHB_UserInfoManager sharedManager]

/** 用户是否登录 */
@property (nonatomic, assign) BOOL isLogin;
/** 用户ID */
@property (nonatomic, copy) NSString *userId;
/** 员工真是姓名 */
@property (nonatomic, copy) NSString *name;
/** 昵称 */
@property (nonatomic, copy) NSString *nickname;
/** 手机号 */
@property (nonatomic, copy) NSString *mobilePhone;
/** token */
@property (nonatomic, copy) NSString *token;
/** 头像 */
@property (nonatomic, copy) NSString *avatar;
/** 个人简介 */
@property (nonatomic, copy) NSString *personalProfile;


/**
 *  用户信息管理器单例
 *
 *  @return 返回唯一的实例
 */
+ (instancetype)sharedManager;

/**
 *  清空用户信息
 */
- (void)removeUserInfo;

/**
 *  缓存用户信息
 */
- (void)setUserInfoWith:(NSDictionary *)dict;





@end

NS_ASSUME_NONNULL_END
