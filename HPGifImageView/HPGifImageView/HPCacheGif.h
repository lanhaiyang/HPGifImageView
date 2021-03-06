//
//  HPCacheGif.h
//  HPCache
//
//  Created by 何鹏 on 17/5/25.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPCacheGif : UIImage


/**
 gif资源

 @param gifName gif名字
 */
-(void)hp_cacheWithGifName:(NSString *)gifName;


/**
 gif资源

 @param data gif 数据
 */
-(void)hp_cacheWithGifData:(NSData *)data;



/**
 判断某个文件是否有缓存

 @param gifName 文件名
 @return 是否有缓存
 */
-(BOOL)hp_getCacheWithGifName:(NSString *)gifName;


/**
 当前gif的帧数
 */
@property(nonatomic,assign) NSUInteger gifCount;


/**
 gif帧 缓存信息
 */
@property(nonatomic,strong,readonly) NSMutableDictionary *cacheAnimationDic;



/**
 设置gif对象

 @param data gif data
 @return 返回HPCacheGif 对象
 */
-(instancetype)initWithAnimatedGIFData:(NSData *)data cacheFileName:(NSURL *)fileName;

@end
