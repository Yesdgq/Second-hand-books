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

// 由userId查询用户信息
- (NSArray <SHB_UserModel *>*)queryUserWithUserId:(NSString *)userId {
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM userList WHERE id like '%@'", userId];
        FMResultSet *res = [db executeQuery:sqlStr];
        while ([res next]) {
            SHB_UserModel *userModel   = [[SHB_UserModel alloc] init];
            userModel.userId           = [NSString stringWithFormat:@"%d", [res intForColumn:@"id"]];
            userModel.name             = [res stringForColumn:@"name"];
            userModel.nickName         = [res stringForColumn:@"nickName"];
            userModel.gender           = [res stringForColumn:@"gender"];
            userModel.mobilePhone      = [res stringForColumn:@"mobilePhone"];
            userModel.avatar           = [res stringForColumn:@"avatar"];
            userModel.personalProfile  = [res stringForColumn:@"personalProfile"];
            
            [dataArray addObject:userModel];
        }
    }];
    
    [_dataBase close];
    return dataArray;
}

// 由nickName查询用户信息
- (NSArray <SHB_UserModel *>*)queryUserWithNickName:(NSString *)nickName {
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM userList WHERE nickName like '%@'", nickName];
        FMResultSet *res = [db executeQuery:sqlStr];
        while ([res next]) {
            SHB_UserModel *userModel   = [[SHB_UserModel alloc] init];
            userModel.userId           = [NSString stringWithFormat:@"%d", [res intForColumn:@"id"]];
            userModel.name             = [res stringForColumn:@"name"];
            userModel.nickName         = [res stringForColumn:@"nickName"];
            userModel.gender           = [res stringForColumn:@"gender"];
            userModel.mobilePhone      = [res stringForColumn:@"mobilePhone"];
            userModel.avatar           = [res stringForColumn:@"avatar"];
            userModel.personalProfile  = [res stringForColumn:@"personalProfile"];
            
            [dataArray addObject:userModel];
        }
    }];
    
    [_dataBase close];
    return dataArray;
}

- (BOOL)updateUserInfoWithUserModel:(SHB_UserModel *)userModel {
    __block BOOL isSuccess;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        isSuccess = [db executeUpdate:@"UPDATE 'userList' SET name = ?, nickName = ?, gender = ?, mobilePhone = ?, avatar = ?, personalProfile = ?  WHERE id = ?", userModel.name, userModel.nickName, userModel.gender, userModel.mobilePhone, userModel.avatar, userModel.personalProfile, userModel.userId];
    }];
    if (isSuccess) {
        DONG_Log(@"更新用户成功：%@", userModel.nickName);
    } else {
        DONG_Log(@"更新用户失败：%@", userModel.nickName);
    }
    
    return isSuccess;
}

- (BOOL)deleteUserWihtUserModel:(SHB_UserModel *)userModel {
    __block BOOL isSuccess;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        isSuccess =  [db executeUpdate:@"DELETE FROM userList WHERE id = ?", userModel.userId];
    }];
    if (isSuccess) {
        DONG_Log(@"删除用户成功：%@", userModel.name);
    } else {
        DONG_Log(@"删除用户失败：%@", userModel.name);
    }
    return isSuccess;
}




/****************************************** 商品信息 *******************************************/

- (void)createBooksTable {
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        // 初始化数据表
        NSString *userList = @"CREATE TABLE 'books' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'bookName' VARCHAR(255), 'author' VARCHAR(255), 'owerID' VARCHAR(255), 'onShelf' INTEGER, 'price' VARCHAR(255), 'area' VARCHAR(255), 'publishTime' VARCHAR(255), 'introduction' VARCHAR(255), 'coverImage' VARCHAR(255))";
        
        BOOL res = [db executeUpdate:userList];
        if (res) {
            DONG_Log(@"books表创建成功");
        } else {
            DONG_Log(@"books表创建失败");
        }
    }];
}

- (BOOL)insertBook:(SHB_GoodsModel *)goodsModel {
    __block BOOL isSuccess;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSNumber *maxID = @(0);
        FMResultSet *result = [db executeQuery:@"SELECT * FROM books"];
        // 获取数据库中最大的ID 自增字段
        while ([result next]) {
            if ([maxID integerValue] < [[result stringForColumn:@"id"] integerValue]) {
                maxID = @([[result stringForColumn:@"id"] integerValue] ) ;
            }
        }
        maxID = @([maxID integerValue] + 1);
        
        isSuccess = [db executeUpdate:@"INSERT INTO books (id, bookName, author, owerID, onShelf, price, area, publishTime, introduction, coverImage) VALUES(?,?,?,?,?,?,?,?,?,?)", maxID, goodsModel.bookName, goodsModel.author, goodsModel.owerID, @(goodsModel.onShelf), goodsModel.price, goodsModel.area, goodsModel.publishTime, goodsModel.introduction, goodsModel.coverImage];
    }];
    
    if (isSuccess) {
        DONG_Log(@"商品插入成功：%@", goodsModel.bookName);
    } else {
        DONG_Log(@"商品插入失败：%@", goodsModel.bookName);
    }
    
    [_dataBase close];
    return isSuccess;
}

- (NSArray <SHB_GoodsModel *>*)queryAllBooksWithOnShelfStatus:(BOOL)onShelf {
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *res = [db executeQuery:@"SELECT * FROM books Where onShelf = ? order by publishTime desc", @(onShelf)];
        while ([res next]) {
            
            SHB_GoodsModel *goodsModel  = [[SHB_GoodsModel alloc] init];
            goodsModel.bookId           = [res stringForColumn:@"id"];
            goodsModel.bookName         = [res stringForColumn:@"bookName"];
            goodsModel.author           = [res stringForColumn:@"author"];
            goodsModel.price            = [res stringForColumn:@"price"];
            goodsModel.introduction     = [res stringForColumn:@"introduction"];
            goodsModel.publishTime      = [res stringForColumn:@"publishTime"];
            goodsModel.coverImage       = [res stringForColumn:@"coverImage"];
            goodsModel.owerID           = [res stringForColumn:@"owerID"];
            goodsModel.onShelf          = [res boolForColumn:@"onShelf"];
            goodsModel.area             = [res stringForColumn:@"area"];
            
            [dataArray addObject:goodsModel];
        }
    }];
    
    [_dataBase close];
    return dataArray;
    
}

- (NSArray <SHB_GoodsModel *>*)queryAllBooksWithUserId:(NSString *)userId {
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *res = [db executeQuery:@"SELECT * FROM books Where owerID = ? order by publishTime desc", userId];
        while ([res next]) {
            
            SHB_GoodsModel *goodsModel  = [[SHB_GoodsModel alloc] init];
            goodsModel.bookId           = [res stringForColumn:@"id"];
            goodsModel.bookName         = [res stringForColumn:@"bookName"];
            goodsModel.author           = [res stringForColumn:@"author"];
            goodsModel.price            = [res stringForColumn:@"price"];
            goodsModel.introduction     = [res stringForColumn:@"introduction"];
            goodsModel.publishTime      = [res stringForColumn:@"publishTime"];
            goodsModel.coverImage       = [res stringForColumn:@"coverImage"];
            goodsModel.owerID           = [res stringForColumn:@"owerID"];
            goodsModel.onShelf          = [res boolForColumn:@"onShelf"];
            goodsModel.area             = [res stringForColumn:@"area"];
            
            [dataArray addObject:goodsModel];
        }
    }];
    
    [_dataBase close];
    return dataArray;
}

- (BOOL)updateBook:(SHB_GoodsModel *)goodsModel {
    
    __block BOOL isSuccess;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        isSuccess =  [db executeUpdate:@"UPDATE 'books' SET onShelf = ? WHERE id = ? ", @(goodsModel.onShelf), goodsModel.bookId];
    }];
    if (isSuccess) {
        DONG_Log(@"更新商品成功：%@", goodsModel.bookName);
    } else {
        DONG_Log(@"更新商品失败：%@", goodsModel.bookName);
    }
    
    return isSuccess;
}

- (BOOL)deleteGoodsWithGoodsModel:(SHB_GoodsModel *)goodModel {
    __block BOOL isSuccess;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        isSuccess =  [db executeUpdate:@"DELETE FROM books WHERE id = ?", goodModel.bookId];
    }];
    if (isSuccess) {
        DONG_Log(@"删除商品成功：%@", goodModel.bookName);
    } else {
        DONG_Log(@"删除商品失败：%@", goodModel.bookName);
    }
    
    return isSuccess;
}

@end
