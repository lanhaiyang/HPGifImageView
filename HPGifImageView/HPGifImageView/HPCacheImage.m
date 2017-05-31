//
//  HPCacheImage.m
//  HPCache
//
//  Created by 何鹏 on 17/5/25.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import "HPCacheImage.h"
#import "HPCache.h"
#import "HPImageCompress.h"

#define HP_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HP_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface HPCacheImage ()

@property(nonatomic,strong) NSString *cacheName;


@end

@implementation HPCacheImage

-(instancetype)initWithCacehName:(NSString *)cacheName
{
    if (self=[super init]) {
        
        _cacheName=cacheName;
        
    }
    return self;
}

-(void)hp_cacheCurrentImage:(UIImage *)cacheImage
{
    if (_cacheName==nil) {
        NSLog(@"cache Image faile why cacheName is nil");
        return;
    }
    
    [HPCache cacheWithObj:UIImagePNGRepresentation([self compressManageImage:cacheImage]) cacheName:self.cacheName];

}

-(UIImage *)compressManageImage:(UIImage *)image
{
    return [self compressWidthImage:[self compressWidthImage:image]];
}

-(UIImage *)compressWidthImage:(UIImage *)image
{
    if (image.size.width>HP_SCREEN_WIDTH) {

        return [HPImageCompress hp_imageCompressForWidth:image targetWidth:HP_SCREEN_WIDTH];
        
    }
    
    return image;
}

-(UIImage *)compressHeightImage:(UIImage *)image
{
    if (image.size.height>HP_SCREEN_HEIGHT) {
        return [HPImageCompress hp_imageCompressForSize:image targetSize:CGSizeMake(image.size.width, HP_SCREEN_HEIGHT)];
    }
    
    return image;
}

-(UIImage *)currentImage
{
    if (self.cacheName==nil) {
        return nil;
    }
    
    NSData *data=[HPCache readWithcacheName:self.cacheName];
    
    return [UIImage imageWithData:data];
}


-(void)setCurrentImage:(UIImage *)currentImage
{
    if (currentImage==nil) {
        self.currentImage=nil;
        return;
    }

    [self hp_cacheCurrentImage:currentImage];
}




@end
