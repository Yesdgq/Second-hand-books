//
//  SHB_UserInfoManager.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/17.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_UserInfoManager.h"

#define k_for_isLogin @"k_for_islogin" // 登录状态
#define k_for_name @"k_for_name" // 姓名
#define k_for_mobilePhone @"k_for_mobilePhone" // 手机
#define k_for_token @"k_for_token" // token
#define k_for_nickname @"k_for_nickname" // 昵称
#define k_for_avatar @"k_for_avatar" // 头像
#define k_for_personalProfile @"k_for_personalProfile" // 简介


@implementation SHB_UserInfoManager

/**
 *  用户信息管理器单例
 *
 *  @return 返回唯一的实例
 */
+ (instancetype)sharedManager {
    static SHB_UserInfoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SHB_UserInfoManager alloc] init];
    });
    return manager;
}

/**
 *  清空用户信息
 */
- (void)removeUserInfo {
    UserInfoManager.isLogin = NO; // 登出
    [DONG_UserDefaults removeObjectForKey:k_for_name]; //
    [DONG_UserDefaults removeObjectForKey:k_for_mobilePhone]; //
    [DONG_UserDefaults removeObjectForKey:k_for_token]; // 
    [DONG_UserDefaults removeObjectForKey:k_for_nickname]; //
    [DONG_UserDefaults removeObjectForKey:k_for_avatar]; //
    [DONG_UserDefaults removeObjectForKey:k_for_personalProfile]; //
    
}
   

/**
 *  缓存用户信息
 */
- (void)setUserInfoWith:(NSDictionary *)dict {
    
}


/**
 *  获取个人信息的请求
 */
- (void)getMyInfoRequest;
{
    
    
}

//******************☝️☝️☝️☝️☝️☝️☝️☝️getter☝️☝️☝️☝️☝️☝️☝️☝️****************
//******************☝️☝️☝️☝️☝️☝️☝️☝️getter☝️☝️☝️☝️☝️☝️☝️☝️****************
//******************☝️☝️☝️☝️☝️☝️☝️☝️getter☝️☝️☝️☝️☝️☝️☝️☝️****************

#pragma mark - getter

// 登录状态
- (BOOL)isLogin
{
    return [DONG_UserDefaults boolForKey:k_for_isLogin];
}

- (NSString *)token
{
    return [DONG_UserDefaults objectForKey:k_for_token];
}

// 姓名
- (NSString *)name
{
    return [DONG_UserDefaults objectForKey:k_for_name];
}

// 昵称
- (NSString *)nickname
{
    return [DONG_UserDefaults objectForKey:k_for_nickname];
}

/** 手机号 */
- (NSString *)mobilePhone
{
    return [DONG_UserDefaults objectForKey:k_for_mobilePhone];
}

/** 头像 */
- (NSString *)avatar
{
    return [DONG_UserDefaults objectForKey:k_for_avatar];
}


// 简介
- (NSString *)personalProfile
{
    return [DONG_UserDefaults objectForKey:k_for_personalProfile];
}



//******************☝️☝️☝️☝️☝️☝️☝️☝️setter☝️☝️☝️☝️☝️☝️☝️☝️****************
//******************☝️☝️☝️☝️☝️☝️☝️☝️setter☝️☝️☝️☝️☝️☝️☝️☝️****************
//******************☝️☝️☝️☝️☝️☝️☝️☝️setter☝️☝️☝️☝️☝️☝️☝️☝️****************

#pragma mark - setter

// 登录状态
- (void)setIsLogin:(BOOL)isLogin
{
    [DONG_UserDefaults setBool:isLogin forKey:k_for_isLogin];
    [DONG_UserDefaults synchronize];
}

- (void)setToken:(NSString *)token
{
    if (![token isKindOfClass:[NSNull class]] && token.length > 0) { // 如果存在保存token
        [DONG_UserDefaults setObject:token forKey:k_for_token];
        [DONG_UserDefaults synchronize];
    }
}

- (void)setName:(NSString *)name
{
    if (![name isKindOfClass:[NSNull class]] && name.length > 0) {
        [DONG_UserDefaults setObject:name forKey:k_for_name];
        [DONG_UserDefaults synchronize];
    }
}

- (void)setNickname:(NSString *)nickname
{
    if (![nickname isKindOfClass:[NSNull class]] && nickname.length > 0) {
        [DONG_UserDefaults setObject:nickname forKey:k_for_nickname];
        [DONG_UserDefaults synchronize];
    }
}

- (void)setMobilePhone:(NSString *)mobilePhone
{
    if (![mobilePhone isKindOfClass:[NSNull class]] && mobilePhone.length > 0) {
        [DONG_UserDefaults setObject:mobilePhone forKey:k_for_mobilePhone];
        [DONG_UserDefaults synchronize];
    }
}

- (void)setAvatar:(NSString *)avatar
{
    if (![avatar isKindOfClass:[NSNull class]] && avatar.length > 0) {
        [DONG_UserDefaults setObject:avatar forKey:k_for_avatar];
        [DONG_UserDefaults synchronize];
    }
}


- (void)setPersonalProfile:(NSString *)personalProfile
{
    if (![personalProfile isKindOfClass:[NSNull class]] && personalProfile.length > 0) {
        [DONG_UserDefaults setObject:personalProfile forKey:k_for_personalProfile];
        [DONG_UserDefaults synchronize];
    }
}




@end
