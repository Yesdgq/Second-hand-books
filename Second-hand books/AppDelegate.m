//
//  AppDelegate.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/17.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "SHB_LonginVC.h"
#import "SHB_BaseNavigationController.h"
#import "DONG_DataBaseManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // 1.初始化键盘控制
    [self initKeyboardManager];
    
    
    // 5.启动设置
    [self setLaunchView];
    
    [DataBaseManager createUserTable];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initKeyboardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;//enable控制整个功能是否启用。
    manager.shouldResignOnTouchOutside = YES;//控制点击背景是否收起键盘。
    manager.shouldToolbarUsesTextFieldTintColor = YES;//控制键盘上的工具条文字颜色是否用户自定义
    manager.enableAutoToolbar = NO;//控制是否显示键盘上的工具条。
}

- (void)setLaunchView {
//    if (UserInfoManager.isLogin) { // 已登录
//
//
    
        SHB_LonginVC *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SHB_LonginVC"];
        // 导航控制器
        SHB_BaseNavigationController *nav = [[SHB_BaseNavigationController alloc] initWithRootViewController:loginVC];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
//
//    } else { // 未登录
//
//        DTHLogInVC *logInVC = DONG_INSTANT_VC_WITH_ID(@"Main", @"DTHLogInVC");
//        // 导航控制器
//        DTHBaseNavigationController *nav = [[DTHBaseNavigationController alloc] initWithRootViewController:logInVC];
//        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//        self.window.rootViewController = nav;
//        [self.window makeKeyAndVisible];
//
//    }
}


@end
