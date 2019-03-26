//
//  UIImage+Compress.h
//  Second-hand books
//
//  Created by yesdgq on 2019/3/26.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Compress)

// 压缩图片质量 二分算法
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength;

/*
 *  压缩图片方法(先压缩质量再压缩尺寸)
 */
-(NSData *)compressWithLengthLimit:(NSUInteger)maxLength;
/*
 *  压缩图片方法(压缩质量)
 */
-(NSData *)compressQualityWithLengthLimit:(NSInteger)maxLength;
/*
 *  压缩图片方法(压缩质量二分法)
 */
-(NSData *)compressMidQualityWithLengthLimit:(NSInteger)maxLength;
/*
 *  压缩图片方法(压缩尺寸)
 */
-(NSData *)compressBySizeWithLengthLimit:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
