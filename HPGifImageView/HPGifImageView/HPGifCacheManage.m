//
//  HPGifCacheManage.m
//  HPGifImageView
//
//  Created by 何鹏 on 17/5/28.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import "HPGifCacheManage.h"
#import "HPCache.h"

#define ManageTime 7*24*60*60

@interface HPGifCacheManage ()

@property(nonatomic,strong) CADisplayLink *cadisplayCacheManage;

@property(nonatomic,strong) UpdateBlock hpDateBlock;

@property(nonatomic,strong) dispatch_queue_t manageQueu;

@end

@implementation HPGifCacheManage

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
        [instance gifSetCacheManage];
    });
    return instance;
}

-(void)gifSetCacheManage
{
    [self gifCacheNotification];
    [self layoutDisplayManage];
}

-(void)layoutDisplayManage
{
    if (self.cadisplayCacheManage!=nil) {
        return;
    }
    
    _manageQueu=dispatch_queue_create("HPGifCacheManage.queue.gif", NULL);
    
    self.cadisplayCacheManage = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAnimationGif)];
    self.cadisplayCacheManage.paused = NO;
    [self.cadisplayCacheManage addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)updateAnimationGif
{
    if (_hpDateBlock!=nil) {
        
        _hpDateBlock();
        
    }
    
    //管理缓存 缓存太大
    dispatch_async(_manageQueu, ^{
        
        NSDictionary *dic=[HPCacehObject.cacheFileInformation objectForKey:ManageSaveFile_KeyFileName_ValueFileSize];
        
        NSArray *sizes=dic.allValues;
        NSUInteger size=0;
        
        for (int i=0; i<sizes.count; i++) {
            
            NSNumber *numberSize=sizes[i];
            size=size+[numberSize integerValue];
            
        }
        
        if (self.maxCache<size) {
            
            NSDictionary *dic=[HPCacehObject.cacheFileInformation objectForKey:ManageSaveFile_KeyFileName_ValueFileSaveTime];
            NSArray *sizeAscending=dic.allValues;
            sizeAscending = [sizeAscending sortedArrayUsingSelector:@selector(compare:)];
            for (int i=0; i<sizeAscending.count; i++) {
                
                NSString *fileName=[dic objectForKey:sizeAscending[i]];
                NSUInteger fileSize=[HPCache fileSizeWithFileName:fileName];
                if (fileSize!=0) {
                    [HPCache removeFile:fileName];
                    size=size-fileSize;
                    if (self.maxCache>size) {
                        break;
                    }
                }
                
            }
            
        }
        
    });
    
}

-(NSUInteger)maxCache
{
    if (_maxCache==0) {
        return 2;
    }
    return _maxCache;
}

-(void)gifCacheNotification
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        //清除缓存 图片取出缩放 降低内存
        self.memoryWarningStatus=YES;
        
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        //缓存时间对象
        [HPCache setCacheFileTime:ManageTime];
        
    }];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:UIApplicationDidReceiveMemoryWarningNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIApplicationDidFinishLaunchingNotification];
}


+(void)hp_updateWithStatus:(UpdateBlock)updateBlock
{
    HPGifCache.hpDateBlock=updateBlock;
}

@end
