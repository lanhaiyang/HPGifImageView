//
//  HPImageCompress.h
//  HPCache
//
//  Created by 何鹏 on 17/5/27.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPImageCompress : UIImage


/**
 压缩图片质量

 @param image 图片
 @param quality 压缩图片质量 (0~1)当小于等于0时默认压缩为0.3 当大于等于1默认压缩为0.7
 @return 返回压缩图片
 */
+(UIImage *)hp_qualityCompressImage:(UIImage *)image toQuality:(CGFloat)quality;

/**
 压缩图片到指定大小

 @param image 图片
 @param maxLength 压缩大小
 @return 返回压缩图片
 */
+ (UIImage *)hp_sizeCompressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;


/**
    二分法压缩:当图片大小小于 maxLength，大于 maxLength * 0.9 时，不再继续压缩。最多压缩 6 次，1/(2^6) = 0.015625 < 0.02，也能达到每次循环 compression 减小 0.02 的效果。这样的压缩次数比循环减小 compression 少，耗时短。需要注意的是，当图片质量低于一定程度时，继续压缩没有效果。也就是说，compression 继续减小，data 也不再继续减小。压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；缺点在于，不能保证图片压缩后小于指定大小。
 
 @param image 图片
 @param maxLength 当图片大小小于 maxLength
 @return 返回压缩图片
 */
+(UIImage *)hp_dichotomyCompressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;


/**
 按照大小压缩

 @param sourceImage 图片
 @param size 压缩指定大小
 @return 返回压缩图片
 */
+(UIImage *)hp_imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;


/**
 按照宽度比压缩

 @param sourceImage 图片
 @param defineWidth 压缩指定宽度
 @return 返回压缩图片
 */
+(UIImage *)hp_imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
