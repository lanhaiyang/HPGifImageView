//
//  GifCollectionViewCell.m
//  HPGifImageView
//
//  Created by 何鹏 on 17/5/31.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import "GifCollectionViewCell.h"
#import "HPCacheGif.h"

@interface GifCollectionViewCell ()

@property(nonatomic,strong) HPCacheGif *hpCacheGif;

@end

@implementation GifCollectionViewCell

-(HPCacheGif *)hpCacheGif
{
    if (_hpCacheGif==nil) {
        _hpCacheGif=[[HPCacheGif alloc] init];
    }
    return _hpCacheGif;
}

-(HPCacheGif *)giftWithGifName:(NSString *)gifName
{
    [self.hpCacheGif hp_cacheWithGifName:gifName];
    return _hpCacheGif;
}

@end
