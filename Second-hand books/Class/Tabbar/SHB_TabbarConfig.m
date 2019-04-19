//
//  SHB_TabbarConfig.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/19.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_TabbarConfig.h"
#import "SHB_HomePageVC.h"
#import "SHB_MyGoodsVC.h"
#import "SHB_MineVC.h"
#import "SHB_DiscoveryVC.h"
#import "SHB_BaseNavigationController.h"
#import "SHB_BookListVC.h"
#import "SHB_UserListVC.h"

static CGFloat const CYLTabBarControllerHeight = 49;

@interface SHB_TabbarConfig ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation SHB_TabbarConfig

#pragma mark - getter

- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero; // UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetZero; // UIOffsetMake(0, MAXFLOAT);
        //        imageInsets = UIEdgeInsetsMake(-0.2, -0.2, -0.2, -0.2);
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                             imageInsets:imageInsets
                                                                                 titlePositionAdjustment:titlePositionAdjustment
                                                                                                 context:self.context];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
        _tabBarController.selectedIndex = 0;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    
    if ([UserInfoManager.nickname isEqualToString:@"admin"]) {
        
        SHB_UserListVC *userListVC = [[SHB_UserListVC alloc] init];
        UIViewController *vc1 = [[SHB_BaseNavigationController alloc] initWithRootViewController:userListVC];
        SHB_BookListVC *bookListVC = [[SHB_BookListVC alloc] init];
        UIViewController *vc2 = [[SHB_BaseNavigationController alloc] initWithRootViewController:bookListVC];
        
        NSArray *viewControllers = @[vc1, vc2];
        return viewControllers;
        
    } else {
        
        SHB_HomePageVC *homePageVC = [[SHB_HomePageVC alloc] init];
        UIViewController *vc1 = [[SHB_BaseNavigationController alloc] initWithRootViewController:homePageVC];
        SHB_MyGoodsVC *goodsVC = [[SHB_MyGoodsVC alloc] init];
        UIViewController *vc2 = [[SHB_BaseNavigationController alloc] initWithRootViewController:goodsVC];
        SHB_DiscoveryVC *discoveryVC = [[SHB_DiscoveryVC alloc] init];
        UIViewController *vc3 = [[SHB_BaseNavigationController alloc] initWithRootViewController:discoveryVC];
        SHB_MineVC *mineVC = [[SHB_MineVC alloc] init];
        UIViewController *vc4 = [[SHB_BaseNavigationController alloc] initWithRootViewController:mineVC];
        
        NSArray *viewControllers = @[vc1, vc2, vc3, vc4];
        return viewControllers;
    }
    
}

- (NSArray *)tabBarItemsAttributesForController {
    
    if ([UserInfoManager.nickname isEqualToString:@"admin"]) {
        
        NSDictionary *dict1 = @{
                                CYLTabBarItemTitle : @"用户管理",
                                CYLTabBarItemImage : @"Mine",
                                CYLTabBarItemSelectedImage : @"Mine_Selected",
                                };
        NSDictionary *dict2 = @{
                                CYLTabBarItemTitle : @"图书管理",
                                CYLTabBarItemImage : @"Goods",
                                CYLTabBarItemSelectedImage : @"Goods_Selected",
                                };
        
        NSArray *tabBarItemsAttributes = @[dict1, dict2];
        return tabBarItemsAttributes;
        
    } else {
        
        NSDictionary *dict1 = @{
                                CYLTabBarItemTitle : @"首页",
                                CYLTabBarItemImage : @"HomePage",
                                CYLTabBarItemSelectedImage : @"HomePage_Selected",
                                };
        NSDictionary *dict2 = @{
                                CYLTabBarItemTitle : @"我的发布",
                                CYLTabBarItemImage : @"Goods",
                                CYLTabBarItemSelectedImage : @"Goods_Selected",
                                };
        NSDictionary *dict3 = @{
                                CYLTabBarItemTitle : @"我的购买",
                                CYLTabBarItemImage : @"Discovery",
                                CYLTabBarItemSelectedImage : @"Discovery_Selected",
                                };
        NSDictionary *dict4 = @{
                                CYLTabBarItemTitle : @"我的",
                                CYLTabBarItemImage : @"Mine",
                                CYLTabBarItemSelectedImage : @"Mine_Selected",
                                };
        
        NSArray *tabBarItemsAttributes = @[dict1, dict2, dict3, dict4];
        return tabBarItemsAttributes;
    }
}

// 更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // 自定义 TabBar 高度
    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : CYLTabBarControllerHeight;
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHex:@"#999999"];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHex:@"#2B7650"];
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    //     [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    //    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    // 设置背景图片
    //UITabBar *tabBarAppearance = [UITabBar appearance];
    //FIXED: #196
    //UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"tab_bar"];
    //UIImage *scanedTabBarBackgroundImage = [[self class] scaleImage:tabBarBackgroundImage toScale:1.0];
    //     [tabBarAppearance setBackgroundImage:scanedTabBarBackgroundImage];
    // 去除 TabBar 自带的顶部阴影
    // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]` 见 AppDelegate 类中的演示;
    //    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

// 横竖屏切换
- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = CYLTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor yellowColor]
                             size:selectionIndicatorImageSize]];
}


+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
