/*
 *    |  ____ \    / ____ \   | |\   | |   / _______|
 *    | |    \ |  / /    \ \  |   \  | |  / /
 *    | |    | |  | |    | |  | |\ \ | |  | |   _____
 *    | |    | |  | |    | |  | | \ \| |  | |  |____ |
 *    | |____/ /  \ \____/ /  | |  \   |  \ \______| |
 *    |_______/    \______/   |_|   \|_|   \_________|
 *
 */
//
//  DONG_DataBaseManager.h
//  iFaceTime
//
//  Created by yesdgq on 2018/3/12.
//  Copyright © 2018年 yesdgq. All rights reserved.
//  数据库管理类

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "SHB_GoodsModel.h"
#import "SHB_UserModel.h"


#define DataBaseManager [DONG_DataBaseManager sharedManager]

@interface DONG_DataBaseManager : NSObject

@property (nonatomic, strong) FMDatabase *dataBase;


+ (instancetype)sharedManager;

// 判断是否存在表
- (BOOL)isTableExisted:(NSString *)tableName;


/****************************************** 用户信息 *******************************************/

- (void)createUserTable;

- (BOOL)insertUser:(SHB_UserModel *)userModel;
// 查询用户是否存在
- (BOOL)queryUserIsExisted:(SHB_UserModel *)userModel;

@end
