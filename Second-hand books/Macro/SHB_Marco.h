//
//  SHB_Marco.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/17.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#ifndef SHB_Marco_h
#define SHB_Marco_h

#define DONG_UserDefaults                        [NSUserDefaults standardUserDefaults]



// NSLog(...)
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif


#ifdef DEBUG
#define DONG_Log2(...) NSLog(@"🔴%s 第%d行 \n %@\n\n",__func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DONG_Log2(...)

#endif

#ifdef DEBUG
#define DONG_Log(...) printf("%s %s 🔴第%d行: %s\n", [[NSDate getNowDateStr] UTF8String], [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define DONG_Log(...)
#endif

#endif /* SHB_Marco_h */
