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
#import "SHB_TabbarConfig.h"
#import "SHB_LonginVC.h"

@interface AppDelegate () <CYLTabBarControllerDelegate, UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // 1.初始化键盘控制
    [self initKeyboardManager];
    
    
    // 5.启动设置
    [self setLaunchView];
    
    [DataBaseManager createUserTable];
    [DataBaseManager createBooksTable];
    [DataBaseManager createBooksBuyingTable];
    [DataBaseManager createCommentListTable];
    [DataBaseManager createNoticeTable];
    
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
    
    if (UserInfoManager.isLogin) { // 已登录
    
        [self initializeTabbar];

    } else { // 未登录

        SHB_LonginVC *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SHB_LonginVC"];
        // 导航控制器
        SHB_BaseNavigationController *nav = [[SHB_BaseNavigationController alloc] initWithRootViewController:loginVC];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];

    }
}


#pragma mark - Tabbar设置

- (void)initializeTabbar {
    //    [IFTPulsButton registerPlusButton];
    SHB_TabbarConfig *tabBarControllerConfig = [[SHB_TabbarConfig alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    self.tabBarController = tabBarController;
    tabBarController.delegate = self;
    UIViewController *currentVC = [UIViewController currentViewController];
    
    if ([currentVC isKindOfClass:[SHB_LonginVC class]]) {
        [currentVC presentViewController:tabBarController animated:YES completion:nil];
    } else {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = tabBarController;
        [self.window makeKeyAndVisible];
    }
    
    [self customizeInterfaceWithTabBarController:tabBarController];
    
}

- (void)customizeInterfaceWithTabBarController:(CYLTabBarController *)tabBarController {
    // 设置导航栏
    //    [self setUpNavigationBarAppearance];
    // 去除 TabBar 自带的顶部阴影 iOS10 后使用
    [tabBarController hideTabBadgeBackgroundSeparator];
    
    @try {
        //        UIView *tabBadgePointView = [UIView cyl_tabBadgePointViewWithClolor:[UIColor redColor] radius:4.5];
        //        [tabBarController.viewControllers[2] cyl_setTabBadgePointView:tabBadgePointView];
        //        [tabBarController.viewControllers[2] cyl_showTabBadgePoint];
        
        // 添加提示动画，引导用户点击
        [self addScaleAnimationOnView:tabBarController.viewControllers[3].cyl_tabButton.cyl_tabImageView repeatCount:10];
    }
    @catch (NSException *exception) {}
}

/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName : [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        textAttributes = @{
                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor : [UIColor blackColor],
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

// 缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    // 需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:@"UserGuide"];
}

// 旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}

#pragma mark - CYLTabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    

    
}



- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIImageView *animationView;
    NSDictionary *message = @{@"selectedIndex" : @(tabBarController.selectedIndex),
                              };
//    [DONG_NotificationCenter postNotificationName:kTabBarClicked object:message];
    
    DONG_Log(@"=====================");
    
    
    
    if ([control cyl_isTabButton]) {
        // 更改红标状态
        //        if ([[self cyl_tabBarController].selectedViewController cyl_isShowTabBadgePoint]) {
        //            [[self cyl_tabBarController].selectedViewController cyl_removeTabBadgePoint];
        //        } else {
        //            [[self cyl_tabBarController].selectedViewController cyl_showTabBadgePoint];
        //        }
        
        animationView = [control cyl_tabImageView];
        
        //        if (tabBarController.selectedIndex == 0) {
        ////            [animationView setImage:[UIImage imageNamed:@"NumPad_Hide"]];
        ////            UITabBarItem *button = tabBarController.tabBarItem;
        ////            [button setSelectedImage:[UIImage imageNamed:@"NumPad_Hide"]];
        //
        ////            if (!firstItemSelected) {
        //                tabBarController.selectedViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"NumPad_Hide"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //
        ////            } else {
        //
        ////            tabBarController.selectedViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"NumPad_Dispay"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ////            }
        ////            firstItemSelected = !firstItemSelected;
        //
        //        } else {
        ////            firstItemSelected = NO;
        //        }
    }
    
    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
    if ([control cyl_isPlusButton]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
    }
    // 可以关闭用户提示动画
            [animationView.layer removeAnimationForKey:@"UserGuide"];
            if ([self cyl_tabBarController].selectedIndex % 2 == 0) {
                [self addScaleAnimationOnView:animationView repeatCount:1];
            } else {
                [self addRotateAnimationOnView:animationView];
            }
}


@end
