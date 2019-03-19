//
//  SHB_TabbarConfig.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHB_TabbarConfig : NSObject

@property (nonatomic, readonly, strong) CYLTabBarController *tabBarController;
@property (nonatomic, copy) NSString *context;

@end

NS_ASSUME_NONNULL_END
