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
#import "SHB_CommentModel.h"


#define DataBaseManager [DONG_DataBaseManager sharedManager]

@interface DONG_DataBaseManager : NSObject

@property (nonatomic, strong) FMDatabase *dataBase;


+ (instancetype)sharedManager;

// 判断是否存在表
- (BOOL)isTableExisted:(NSString *)tableName;


/****************************************** 用户信息 *******************************************/

- (void)createUserTable;

- (BOOL)insertUser:(SHB_UserModel *)userModel;

/**
 *  登录查询 —— 用昵称和密码进行校验
 *
 */
- (BOOL)whetherLoginSuccessWithUser:(SHB_UserModel *)userModel;

/**
 *  查询用户在不在 —— 使用nickName查询
 *
 */
- (BOOL)queryUserIsExistedWithNickName:(SHB_UserModel *)userModel;

/**
 *  由userId查询用户信息
 *
 */
- (NSArray <SHB_UserModel *>*)queryUserWithUserId:(NSString *)userId;

/**
 *  由nickName查询用户信息
 *
 */
- (NSArray <SHB_UserModel *>*)queryUserWithNickName:(NSString *)nickName;

/**
 *  查询所有用户
 *
 */
- (NSArray <SHB_UserModel *>*)queryAllUsers;

/**
 *  更新用户信息
 *
 *  @return BOOL
 */
- (BOOL)updateUserInfoWithUserModel:(SHB_UserModel *)userModel;

/**
 *  删除用户
 *
 */
- (BOOL)deleteUserWihtUserModel:(SHB_UserModel *)userModel;


/****************************************** 商品信息 *******************************************/

/**
 *  创建书table
 *
 */
- (void)createBooksTable;

/**
 *  出入新书
 *
 *  @return BOOL
 */
- (BOOL)insertBook:(SHB_GoodsModel *)goodsModel;

/**
 *  查询所有图书
 *
 *  @return 返回数组<SHB_GoodsModel *>书对象
 */
- (NSArray <SHB_GoodsModel *>*)queryAllBooksWithOnShelfStatus:(BOOL)onShelf;

/**
 *  查询指定人所有图书
 *
 *  @return 返回数组<SHB_GoodsModel *>书对象
 */
- (NSArray <SHB_GoodsModel *>*)queryAllBooksWithUserId:(NSString *)userId;

/**
 *  更新Book
 *
 */
- (BOOL)updateBook:(SHB_GoodsModel *)goodsModel;

/**
 *  删除
 *
 */
- (BOOL)deleteGoodsWithGoodsModel:(SHB_GoodsModel *)goodModel;

/**
 *  查询所有商品
 *
 */
- (NSArray <SHB_GoodsModel *>*)queryAllBooks;

/****************************************** 商品购买 *******************************************/

/**
 *  创建购买记录table
 *
 */
- (void)createBooksBuyingTable;

/**
 *  买书
 *
 *  @return BOOL
 */
- (BOOL)insertBook:(SHB_GoodsModel *)goodsModel userId:(NSString *)userId;

/**
 *  查询已经买的书
 *
 *  @return BOOL
 */
- (NSArray <SHB_GoodsModel *>*)queryBooksBoughtWithUser:(SHB_UserModel *)userModel;


/****************************************** 用户留言 *******************************************/

/**
 *  创建评论表
 *
 */
- (void)createCommentListTable;

/**
 *  插入评论
 *
 *  @return BOOL
 */
- (BOOL)insertComment:(SHB_CommentModel *)commentModel userId:(NSString *)userId;

/**
 *  删除
 *
 */
- (BOOL)deleteCommentWithCommentModel:(SHB_CommentModel *)commentModel;

/**
 *  查询评论
 *
 *  @return BOOL
 */
- (NSArray <SHB_CommentModel *>*)queryAllComments;

@end
