//
//  HPGifImageView.h
//  HPCache
//
//  Created by 何鹏 on 17/5/25.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPCacheGif.h"

typedef void (^AnimationEndBlock)(id weakObj);

@interface HPGifImageView : UIImageView


/**
 HPCacheGif gif 对象
 */
@property(nonatomic,strong) HPCacheGif *cacheGif;

@property(nonatomic,strong) NSString *loopModel;


/**
 每次循环播放结束回调

 @param weakObj 需要弱引用的对象
 @param completeBlock 结束
 */
-(void)hp_weakObj:(id)weakObj gifAnimationComplete:(AnimationEndBlock)completeBlock;


/**
 开始播放gif
 */
- (void)startShowAnimation;


/**
 停止gif
 */
- (void)stopShowAnimation;


/**
 暂停gif
 */
-(void)pausedShowAnimation;

@property(nonatomic,assign) BOOL isVisual;

/**
 请求网络等到图片

 @param url 请求图片链接
 @param defaultImage 默认图片
 */
- (void)hp_loadAnimatedImageWithURL:(NSURL *const)url defaultImage:(UIImage *)defaultImage;

@end
