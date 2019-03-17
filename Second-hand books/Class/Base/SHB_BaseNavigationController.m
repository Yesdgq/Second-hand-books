//
//  SHB_BaseNavigationController.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/17.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_BaseNavigationController.h"
#import <objc/runtime.h>

@interface SHB_BaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation SHB_BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 设置导航栏图片和颜色
    //    UIImage *backGroundImage = [UIImage imageNamed:@"NavigationBar"];
    //    backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    //    [self.navigationBar setBackgroundImage:backGroundImage forBarMetrics:UIBarMetricsDefault];
    
    //    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBar"] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavigationBar"]];
    //    self.navigationBar.shadowImage = [[UIImage alloc] init];
    
    
    // 返回箭头颜色
    [self.navigationBar setTintColor:[UIColor blackColor]];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"返回";
    self.navigationItem.backBarButtonItem = backBtn;
    // title颜色
    self.navigationBar.barStyle = UIBarStyleDefault;
    // title颜色和大小
    //    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
    // built-in pop recognizer
    UIGestureRecognizer *recognizer = self.interactivePopGestureRecognizer;
    recognizer.enabled = NO;
    UIView *gestureView = recognizer.view;
    
    // pop recognizer
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    self.popRecognizer = popRecognizer;
    
    // taget-action reflect
    NSMutableArray *actionTargets = [recognizer valueForKey:@"_targets"];
    id actionTarget = [actionTargets firstObject];
    id target = [actionTarget valueForKey:@"_target"];
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    [popRecognizer addTarget:target action:action];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // 当要popto的页面为短信验证页面或登录页时 不返回
    //    DONG_Log(@"viewControllers -->%@",self.viewControllers);
    //    DONG_Log(@"即将返回到的页面VC-->%@",self.childViewControllers[self.viewControllers.count-2]);
    return self.viewControllers.count > 1 && ![[self valueForKey:@"_isTransitioning"] boolValue] && [gestureRecognizer translationInView:gestureRecognizer.view].x > 0;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

// 支持横竖屏显示
- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}

// 支持设备自动旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

@end
