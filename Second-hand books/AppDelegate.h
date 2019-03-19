//
//  AppDelegate.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/17.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CYLTabBarController *tabBarController;

- (void)initializeTabbar;

@end

