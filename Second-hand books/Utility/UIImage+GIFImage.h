//
//  UIImage+GIFImage.h
//  DTH Service App
//
//  Created by yesdgq on 2018/11/13.
//  Copyright © 2018 yesdgq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^GIFimageBlock)(UIImage *GIFImage);

@interface UIImage (GIFImage)

/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */
+ (void)imageWithGIFUrl:(NSString *)url completion:(GIFimageBlock)completionHandler;


@end

NS_ASSUME_NONNULL_END
