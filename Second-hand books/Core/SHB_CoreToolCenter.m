//
//  SHB_CoreToolCenter.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/17.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_CoreToolCenter.h"
#import "SVProgressHUD.h"
#import "UIImage+GIFImage.h"

@implementation SHB_CoreToolCenter

+ (void)load {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    //[SVProgressHUD setBackgroundColor:[UIColor colorWithRed:54/255 green:63/255 blue:81/255 alpha:.7]];
    //[SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:12]];
    [SVProgressHUD setInfoImage:[UIImage imageNamed:@""]];
    //[SVProgressHUD setSuccessImage:[UIImage imageNamed:@"success"]];
    //[SVProgressHUD setErrorImage:[UIImage imageNamed:@"error"]];
    [SVProgressHUD setMaximumDismissTimeInterval:2.f];
    [SVProgressHUD setCornerRadius:8];
    //[SVProgressHUD setShouldTintImages:false];
    
}

void ShowSuccessStatus(NSString *status) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:status];
    });
}

void ShowMessage(NSString *status) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showInfoWithStatus:status];
    });
}

void ShowErrorStatus(NSString *status) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:status];
    });
}

void ShowMaskStatus(NSString *status) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showWithStatus:status];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    });
}

void ShowCustomerMaskStatus(NSString *status) {
    if (status.length == 0 || status == nil) {
        status = @"加载中...";
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showImage:[UIImage imageWithGIFNamed:@"timg"] status:status];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    });
}

void ShowProgress(CGFloat progress) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showProgress:progress];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    });
}

void ShowProgressWithStatus(CGFloat progress, NSString *status) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showProgress:progress status:status];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    });
}

void DismissHud(void) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


@end
