//
//  NSDictionary+Addition.h
//  SevenColorMovies
//
//  Created by yesdgq on 2017/10/23.
//  Copyright © 2017年 yesdgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Addition)

// json字符串转字典
+ (id)objectWithJsonString:(NSString *)jsonString;
// 字典转json字符串方法
+ (NSString *)jsonStringFromObject:(id)obj;

@end
