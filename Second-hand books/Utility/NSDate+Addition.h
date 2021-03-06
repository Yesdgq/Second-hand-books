//
//  NSDate+Addition.h
//  SevenColorMovies
//
//  Created by yesdgq on 16/8/23.
//  Copyright © 2016年 yesdgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

// 当前现在日期类转换成时间戳
- (NSString *)getTimeStamp;

// 返回当前时间字符串：@"YYYY-MM-dd hh:mm:ss"
+ (NSString *)getNowDateStr;
// 按指定格式返回当前时间字符串
+ (NSString *)getCurrentDateStringWithFormat:(NSString *)format;

// 时间戳转换成NSDate对象
+ (NSDate *)getDateWithTimeStamp:(NSString *)timeStamp;

/**
 *  字符串转NSDate
 *
 *  @param timeStr 字符串时间
 *  @param format  转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return NSDate对象
 */
+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format;

/**
 *  NSDate转时间戳
 *
 *  @param date 字符串时间
 *
 *  @return 返回时间戳
 */
+ (NSInteger)timeStampFromDate:(NSDate *)date;


/**
 *  字符串转时间戳
 *
 *  @param timeStr 字符串时间
 *  @param format  转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回时间戳的字符串
 */
+(NSInteger)timeStampFromString:(NSString *)timeStr
                          format:(NSString *)format;

/**
 *  时间戳转字符串
 *
 *  @param timeStamp 时间戳
 *  @param format    转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)dateStrFromTimeStampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format;


/**
 *  NSDate转字符串
 *
 *  @param date   NSDate时间
 *  @param format 转化格式 如yyyy-MM-dd HH:mm:ss,即2015-07-15 15:00:00
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)dateStringFromDate:(NSDate *)date
               withDateFormat:(NSString *)format;



@end
