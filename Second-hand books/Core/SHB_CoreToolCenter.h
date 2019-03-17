//
//  SHB_CoreToolCenter.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/17.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHB_CoreToolCenter : NSObject

extern void ShowSuccessStatus(NSString *status);
extern void ShowErrorStatus(NSString *status);
extern void ShowMaskStatus(NSString *_Nullable status);
extern void ShowCustomerMaskStatus(NSString *_Nullable status);
extern void ShowMessage(NSString *status);
extern void ShowProgress(CGFloat progress);
extern void ShowProgressWithStatus(CGFloat progress, NSString *status);
extern void DismissHud(void);

@end

NS_ASSUME_NONNULL_END
