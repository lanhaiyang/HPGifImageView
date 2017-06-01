//
//  HPCacheGif.m
//  HPCache
//
//  Created by 何鹏 on 17/5/25.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import "HPCacheGif.h"
#import "HPCache.h"
#import <ImageIO/ImageIO.h>
#import "HPCacheImage.h"
#import "HPGifCacheManage.h"

@interface HPCacheGif ()

@property(nonatomic,strong) NSMutableDictionary *cacheDictionary;

@end

@implementation HPCacheGif


-(instancetype)initWithAnimatedGIFData:(NSData *)data cacheFileName:(NSURL *)fileName
{
    if (self=[super init]) {
        
        [self hp_animationGifWith:data acheFileName:fileName];
        
    }
    return self;
}

-(BOOL)hp_getCacheWithGifName:(NSString *)gifName
{
    if (gifName==nil) {
        return NO;
    }
    
    NSArray *chileFile=[HPCache chileFileWithfielName:gifName];
    
    if (chileFile.count==0) {
        return NO;
    }
    
    _cacheAnimationDic=self.cacheDictionary;
    
    for (int i=0; i<chileFile.count; i++) {
        
        [HPCacheGif dataNameWithFile:gifName
                       cacheDication:_cacheDictionary
                            duration:i];
        
    }
    
    if (chileFile>0) {
        _gifCount=chileFile.count;
        [self hp_cacheWithGifData:nil acheFileName:nil];
        return YES;
    }
    return NO;
    
}

-(void)hp_cacheWithGifName:(NSString *)gifName
{
    NSURL *gifUrl=[[NSBundle mainBundle] URLForResource:gifName withExtension:@"gif"];
    NSData *data=[NSData dataWithContentsOfURL:gifUrl options:NSDataReadingMappedIfSafe error:nil];
    
    [self hp_cacheWithGifData:data];
}

-(void)hp_cacheWithGifData:( NSData *)data
{
    if (data==nil) {
        return;
    }
    
    [self hp_cacheWithGifData:data acheFileName:nil];
}

-(void)hp_cacheWithGifData:( NSData *)data acheFileName:(NSURL *)fileName
{
    dispatch_async(HPGifCache.manageQueu, ^{
        
        [self hp_animationGifWith:data acheFileName:fileName];
        
    });
    
}

-(void)hp_animationGifWith:(NSData *)data acheFileName:(NSURL *)fileName
{
    if (data==nil) {
        return ;
    }
    
    _data=data;
    
    _cacheAnimationDic=self.cacheDictionary;
    
    CGImageSourceRef source=CGImageSourceCreateWithData((__bridge CFDataRef)_data, NULL);
    
    size_t count=CGImageSourceGetCount(source);
    _gifCount=count;
    NSString *cacheName=nil;
    
    if (fileName!=nil) {
        cacheName=[fileName description];
    }
    else
    {
        cacheName=[HPCache md5:[data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]];
    }
    
    if (count<=1) {
        
        [HPCache cacheWithObj:data cacheName:[HPCache md5:cacheName]];
    }
    else
    {
        NSUInteger duration=0;
        BOOL isCreat=[HPCache creatFile:cacheName creatWithPath:[HPCache getCachePath]];
        
        NSUInteger cacheFileCount=[HPCacheGif filePathWithGifImageConnt:cacheName];
        
        for (size_t i=0; i<count; i++) {
            
            if (isCreat==YES || cacheFileCount<count) {
                
                CGImageRef imageRef=CGImageSourceCreateImageAtIndex(source, i, NULL);
                UIImage *image=[UIImage imageWithCGImage:imageRef];
                
                NSString *dataName=[HPCacheGif dataNameWithFile:cacheName
                                                  cacheDication:_cacheDictionary
                                                       duration:duration];
                HPCacheImage *cacheImage=[[HPCacheImage alloc] initWithCacehName:dataName];
                [cacheImage setCurrentImage:image];
                
                CGImageRelease(imageRef);
                
            }
            else
            {
                [HPCacheGif dataNameWithFile:cacheName
                               cacheDication:_cacheDictionary
                                    duration:duration];
            }
            
            duration=duration+1;
            
        }
        
    }
    
    CFRelease(source);
    
}

+(NSUInteger)filePathWithGifImageConnt:(NSString *)fileName
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",[HPCache getCachePath],fileName];
    NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:filePath error:nil]];
    
    return tempFileList.count;
}

+(NSString *)dataNameWithFile:(NSString *)cacheFile
                cacheDication:(NSMutableDictionary *)cacheDictionary
                     duration:(NSUInteger)duration
{
    NSString *dataName=[NSString stringWithFormat:@"%@/%ld",cacheFile,duration];
    [cacheDictionary setValue:dataName forKey:[NSString stringWithFormat:@"%ld",duration]];
    return dataName;
}

-(NSMutableDictionary *)cacheDictionary
{
    if (_cacheDictionary==nil) {
        _cacheDictionary=[NSMutableDictionary dictionary];
    }
    return _cacheDictionary;
}

@end
