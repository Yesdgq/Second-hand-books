//
//  NSString+Dong.h
//  SevenColorMovies
//
//  Created by yesdgq on 16/8/5.
//  Copyright © 2016年 yesdgq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Dong)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGFloat)heightForLineWithFont:(UIFont *)font;

- (NSMutableAttributedString *)attributedString;

- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font;

- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;

- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing;

- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font color:(UIColor *)color lineSpacing:(CGFloat)lineSpacing characterSpacing:(CGFloat)spacing firstLineSpacing:(CGFloat)firstSpacing;

- (BOOL)isMoreThanOneLineConstraintToWidth:(CGFloat)width withFont:(UIFont *)font;

// 判断是否为空
+ (BOOL)isBlankString:(NSString *)str;
// 有效字符
+ (NSString *)effectiveString:(NSString *)originalStr;

+ (instancetype)stringFromIntValue:(int)intValue;
+ (instancetype)stringFromIntegerValue:(NSInteger)integerValue;
+ (instancetype)stringFromUIntegerValue:(NSUInteger)uIntValue;
+ (instancetype)stringFromBOOLValue:(BOOL)boolValue;
+ (instancetype)stringFromNowDate;
+ (instancetype)absoluteStringFromNowDate;

- (instancetype)stringByTrimmingWhitespaceAndNewline;
- (instancetype)stringByTrimmingNewline;
- (instancetype)stringByTrimmingString:(NSString *)string;
// 去除中横线
- (instancetype)stringByTrimmingHyphen;
// 去除空格
- (instancetype)stringByTrimmingBlank;
// 去除冒号
- (instancetype)stringByTrimmingColon;
// 去掉等号
- (instancetype)stringByTrimmingEqualMark;
- (instancetype)absoluteDateString;
// Base64
- (instancetype)stringByBase64Encoding;
- (instancetype)stringByBase64Decoding;

/* 
 * 获取时间戳
 *
 * hh与HH的区别:分别表示12小时制,24小时制
 * @"YYYY-MM-dd HH:mm:ss"
 * @"yyyy年MM月dd日 HH时mm分ss秒"
 * @"MM-dd-yyyy HH-mm-ss"
 */
- (double)timestampWithDateFormat:(NSString *)dateFormat;

/*
 * 获取json字符串
 *
 * 将dictionary、array等转成json字符串
 */
+ (NSString *)convertObjectToJsonString:(id)obj;

//*****************************☝️☝️☝️☝️☝️☝️字符合法校验☝️☝️☝️☝️☝️☝️☝️☝️*******************

+ (BOOL)verifyJobNumber:(NSString *)input; // 工号校验
+ (BOOL)verifyCNName:(NSString *)input; // 中文姓名校验
+ (BOOL)verifyDetailAddress:(NSString *)input; // 校验详细地址
+ (BOOL)verifyAddress:(NSString *)input; // 地址校验
+ (BOOL)verifyMobilePhone:(NSString *)input; // 校验手机号
+ (BOOL)verifyTelephone:(NSString *)input; // 座机验证
+ (BOOL)verifyZipCode:(NSString *)input; // 邮编校验
+ (BOOL)verifyNewAddress:(NSString *)input;

//*****************************☝️☝️☝️☝️☝️☝️Des加密☝️☝️☝️☝️☝️☝️☝️☝️*******************

+ (NSString *)getDesEncrypStr:(NSString *)str;
+ (NSString *)getDesDecrypStringWithString:(NSString *)encryptStr;

@end
