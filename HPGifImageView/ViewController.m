//
//  ViewController.m
//  HPGifImageView
//
//  Created by 何鹏 on 17/5/28.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import "ViewController.h"
#import "HPGifImageView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HPCacheGif *cacheGif=[[HPCacheGif alloc] init];
    [cacheGif hp_cacheWithGifName:@"runCar"];
    
    HPGifImageView *gifImageView=[[HPGifImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    gifImageView.cacheGif=cacheGif;
    
    
    
    HPCacheGif *cacheGif2=[[HPCacheGif alloc] init];
    [cacheGif2 hp_cacheWithGifName:@"Qmonkey"];
    
    HPGifImageView *gifImageView2=[[HPGifImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    gifImageView2.cacheGif=cacheGif2;
    
    
    HPCacheGif *cacheGif3=[[HPCacheGif alloc] init];
    [cacheGif3 hp_cacheWithGifName:@"kissAnimation"];
    
    HPGifImageView *gifImageView3=[[HPGifImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    gifImageView3.cacheGif=cacheGif3;

    [self.view addSubview:gifImageView];
    [self.view addSubview:gifImageView2];
    [self.view addSubview:gifImageView3];
    
    HPGifImageView *gifImageVIew4=[[HPGifImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [gifImageVIew4 hp_loadAnimatedImageWithURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"] defaultImage:nil];
    [self.view addSubview:gifImageVIew4];
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
