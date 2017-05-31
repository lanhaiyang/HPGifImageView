//
//  HPGifCacheManage.h
//  HPGifImageView
//
//  Created by 何鹏 on 17/5/28.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HPGifCache [HPGifCacheManage sharedManager]

typedef NS_ENUM(NSUInteger,GIFCACHEMANAGE) {
    ENUM_HP_xxx
};

typedef void (^UpdateBlock)();

@interface HPGifCacheManage : UIView

+ (instancetype)sharedManager;

@property(nonatomic,assign) NSUInteger maxCache;//MB

//内存警告状态 默认为NO  如果为YES(出现内存警告)
@property(nonatomic,assign) BOOL memoryWarningStatus;

+(void)hp_updateWithStatus:(UpdateBlock)updateBlock;

@end
