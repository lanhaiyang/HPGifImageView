//
//  HPCacheImage.h
//  HPCache
//
//  Created by 何鹏 on 17/5/25.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPCacheImage : UIImage


/**
 当前Image的图片

 @param currentImage 缓存当前的图片
 */
-(void)setCurrentImage:(UIImage *)currentImage;


/**
 通过图片名字得到缓存对象

 @param cacheName 图片名字
 @return 缓存后的HPCacheImage
 */
-(instancetype)initWithCacehName:(NSString *)cacheName;

@end
