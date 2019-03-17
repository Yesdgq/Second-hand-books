//
//  SHB_BaseNavigationController.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/17.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHB_BaseNavigationController : UINavigationController

@property (nonatomic, strong) UIPanGestureRecognizer *popRecognizer;

@end

NS_ASSUME_NONNULL_END
