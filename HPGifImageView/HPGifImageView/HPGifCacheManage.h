//
//  HPGifCacheManage.h
//  HPGifImageView
//
//  Created by 何鹏 on 17/5/28.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HPGifCache [HPGifCacheManage sharedManager]

typedef void (^UpdateBlock)();

@interface HPGifCacheManage : UIView


/**
 单例管理

 @return 管理对象
 */
+ (instancetype)sharedManager;

@property(nonatomic,assign) NSUInteger maxCache;//MB

//内存警告状态 默认为NO  如果为YES(出现内存警告)
@property(nonatomic,assign) BOOL memoryWarningStatus;


@property(nonatomic,strong) dispatch_queue_t manageQueu;

/**
 更新状态

 @param updateBlock 更新操作
 */
+(void)hp_updateWithStatus:(UpdateBlock)updateBlock;

@end
