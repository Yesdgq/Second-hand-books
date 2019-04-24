//
//  SHB_CommentModel.h
//  Second-hand books
//
//  Created by yesdgq on 2019/4/24.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHB_CommentModel : NSObject

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *customerId;
@property (nonatomic, copy) NSString *creatTime;
@property (nonatomic, copy) NSString *customerNickName;

@end

NS_ASSUME_NONNULL_END
