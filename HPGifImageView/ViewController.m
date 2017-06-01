//
//  ViewController.m
//  HPGifImageView
//
//  Created by 何鹏 on 17/5/28.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import "ViewController.h"
#import "HPGifImageView.h"
#import "GifCollectionViewCell.h"
#import "GifCollectionReusableView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define cellId @"GifCollectionViewCell"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *GifCollectionView;

@property(nonatomic,strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     
     HPCacheGif *cacheGif=[[HPCacheGif alloc] init];
     [cacheGif hp_cacheWithGifName:@"runCar"];
     
     HPGifImageView *gifImageView=[[HPGifImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
     gifImageView.cacheGif=cacheGif;
     [self.view addSubview:gifImageView];
     
     HPGifImageView *gifImageVIew4=[[HPGifImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
     [gifImageVIew4 hp_loadAnimatedImageWithURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"] defaultImage:nil];
     [self.view addSubview:gifImageVIew4];
     
     */
    
    self.GifCollectionView.delegate=self;
    self.GifCollectionView.dataSource=self;
  
}

-(NSArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=@[@"runCar",@"kissAnimation",@"Qmonkey",@"runCar",@"kissAnimation",@"Qmonkey",@"runCar",@"kissAnimation",@"Qmonkey",@"runCar",@"kissAnimation",@"Qmonkey",@"runCar",@"kissAnimation",@"Qmonkey",@"kissAnimation",@"runCar",@"Qmonkey",@"runCar",@"runCar",@"kissAnimation",@"Qmonkey",@"runCar",@"kissAnimation",@"Qmonkey",@"runCar",@"kissAnimation",@"runCar",@"kissAnimation",@"Qmonkey",@"runCar",@"kissAnimation",@"kissAnimation",@"runCar",@"Qmonkey",@"Qmonkey",@"runCar"];
    }
    return _dataArray;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GifCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.gifImageView.cacheGif=[cell giftWithGifName:self.dataArray[indexPath.row]];
    
    return cell;
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        GifCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GifHeadeView" forIndexPath:indexPath];
        [headerView.gifHeadeView hp_loadAnimatedImageWithURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"] defaultImage:nil];
        
        return headerView;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/4,100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
