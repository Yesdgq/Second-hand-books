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
//  DONG_DataBaseManager.m
//  iFaceTime
//
//  Created by yesdgq on 2018/3/12.
//  Copyright © 2018年 yesdgq. All rights reserved.
//

#import "DONG_DataBaseManager.h"
#import "FMDatabaseQueue.h"


@interface DONG_DataBaseManager()

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

@implementation DONG_DataBaseManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static DONG_DataBaseManager *dbManager = nil;
    dispatch_once(&onceToken, ^{
        dbManager = [[self alloc] init];
        [dbManager initializeDataBase];
    });
    
    return dbManager;
}

// 创建数据库
- (void)initializeDataBase {
    NSString *doc = [FileManageCommon GetDocumentPath];
    NSString *filePath = [doc stringByAppendingPathComponent:@"secondHandBooks.sqlite"];
    DONG_Log(@"数据库路径：%@", filePath);
    // 创建数据库
    self.dataBase = [FMDatabase databaseWithPath:filePath];
    
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:filePath];
}

// 判断是否存在表
- (BOOL)isTableExisted:(NSString *)tableName {
    FMResultSet *rs = [_dataBase executeQuery:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type ='table' and name = ?", tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        
        if (0 == count) {
            DONG_Log(@"%@表不存在，请创建", tableName);
            return NO;
        } else {
            DONG_Log(@"%@表已经存在", tableName);
            return YES;
        }
    }
    return NO;
}

// 打开数据库
- (void)readyDatabase {
    if (![_dataBase open]) {
        [_dataBase close];
        NSAssert1(0, @"Failed to open database file with message '%@'.", [_dataBase lastErrorMessage]);
    }
    
    [_dataBase setShouldCacheStatements:YES];
}


/****************************************** 用户信息 *******************************************/

- (void)createUserTable {
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        // 初始化数据表
        NSString *userList = @"CREATE TABLE 'userList' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'name' VARCHAR(255), 'nickName' VARCHAR(255), 'gender' VARCHAR(255), 'mobilePhone' VARCHAR(255), 'avatar' VARCHAR(255), 'personalProfile' VARCHAR(255), 'password' VARCHAR(255))";
        
        BOOL res = [db executeUpdate:userList];
        if (res) {
            DONG_Log(@"userList表创建成功");
        } else {
            DONG_Log(@"userList表创建失败");
        }
    }];
}

// 插入用户
- (BOOL)insertUser:(SHB_UserModel *)userModel {
    __block BOOL isSuccess;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSNumber *maxID = @(0);
        FMResultSet *result = [db executeQuery:@"SELECT * FROM userList"];
        // 获取数据库中最大的ID 自增字段
        while ([result next]) {
            if ([maxID integerValue] < [[result stringForColumn:@"id"] integerValue]) {
                maxID = @([[result stringForColumn:@"id"] integerValue] ) ;
            }
        }
        maxID = @([maxID integerValue] + 1);
        isSuccess = [db executeUpdate:@"INSERT INTO userList (id, name, nickName, gender, mobilePhone, avatar, personalProfile, password) VALUES(?,?,?,?,?,?,?,?)", maxID, userModel.name, userModel.nickName, userModel.gender, userModel.mobilePhone, userModel.avatar, userModel.personalProfile, userModel.password];
    }];
    
    if (isSuccess) {
        DONG_Log(@"用户插入成功：%@", userModel.nickName);
    } else {
        DONG_Log(@"用户插入失败：%@", userModel.nickName);
    }
    
    [_dataBase close];
    return isSuccess;
}

// 登录查询 —— 用昵称和密码进行校验
- (BOOL)whetherLoginSuccessWithUser:(SHB_UserModel *)userModel {
    __block BOOL isSuccess;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *res = [db  executeQuery:@"SELECT count(*) as 'count' FROM userList WHERE nickName = ? and password = ?", userModel.nickName, userModel.password];
        while ([res next]) {
            NSInteger count = [res intForColumn:@"count"];
            if (count == 0) {
                isSuccess = NO;
            } else {
                isSuccess = YES;
            }
        }
    }];
    [_dataBase close];
    return isSuccess;
}

// 查询用户在不在 —— 使用nickName查询
- (BOOL)queryUserIsExistedWithNickName:(SHB_UserModel *)userModel {
    __block BOOL isSuccess;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *res = [db  executeQuery:@"SELECT count(*) as 'count' FROM userList WHERE nickName = ?", userModel.nickName];
        while ([res next]) {
            NSInteger count = [res intForColumn:@"count"];
            if (count == 0) {
                isSuccess = NO;
            } else {
                isSuccess = YES;
            }
        }
    }];
    [_dataBase close];
    return isSuccess;
}





@end
