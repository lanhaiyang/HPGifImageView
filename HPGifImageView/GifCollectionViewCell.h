//
//  GifCollectionViewCell.h
//  HPGifImageView
//
//  Created by 何鹏 on 17/5/31.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HPGifImageView;
@class HPCacheGif;

@interface GifCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet HPGifImageView *gifImageView;

-(HPCacheGif *)giftWithGifName:(NSString *)gifName;

@end
