//
//  HPGifImageView.m
//  HPCache
//
//  Created by 何鹏 on 17/5/25.
//  Copyright © 2017年 何鹏. All rights reserved.
//

#import "HPGifImageView.h"
#import "HPCache.h"
#import "HPGifCacheManage.h"
#import "HPImageCompress.h"

@interface HPGifImageView ()

@property(nonatomic,strong) CADisplayLink *displayLink;

@property(nonatomic,assign) NSUInteger gifMaxNumber;

@property(nonatomic,weak) id hpWeakObj;

@property(nonatomic,strong) AnimationEndBlock endBlock;

@property(nonatomic,strong) UIImage *showImage;

@end

@implementation HPGifImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self layoutImage];
    }
    return self;
}

-(instancetype)init
{
    if (self=[super init]) {
        [self layoutImage];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self layoutImage];
    }
    return  self;
}

-(void)setDefaultImage:(UIImage *)defaultImage
{
    if (defaultImage==nil) {
        return;
    }
    self.image=defaultImage;
}

-(void)layoutImage
{
    if (self.displayLink!=nil) {
        return;
    }
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAnimationGif)];
    self.displayLink.paused = NO;
    self.displayLink.frameInterval=[self frameDelayGreatestCommonDivisor:0.03];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [HPGifCacheManage hp_updateWithStatus:^{
        
        if (_isVisual==YES) {
            [self pausedShowAnimation];
        }
        else
        {
            [self startShowAnimation];
        }
        
    }];
}

- (NSInteger)frameDelayGreatestCommonDivisor:(NSTimeInterval )time
{
    if (time==0) {
        time=0.03;
    }
    CGFloat updateTime=time*60;
    NSInteger upTime=(NSInteger)updateTime;
    CGFloat laterTime=updateTime-upTime;
    
    if (laterTime==0) {
        return 1;
    }
    else
    {
        if (laterTime<0.5) {
            return upTime;
        }
        else
        {
            return updateTime+1;
        }
    }
}



-(void)updateAnimationGif
{
    NSString *currentNumber=[NSString stringWithFormat:@"%lu",_gifMaxNumber];
    if ([_cacheGif.cacheAnimationDic.allKeys containsObject:currentNumber]) {
        
        NSString *gifName=[_cacheGif.cacheAnimationDic objectForKey:currentNumber];
        UIImage *image=[UIImage imageWithData:[HPCache readWithcacheName:gifName]];
        
        if (HPGifCache.memoryWarningStatus==YES) {
            image=[HPImageCompress hp_imageCompressForSize:image targetSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height)];
            self.showImage=[HPGifImageView cgImageWithShow:image];
        }
        else
        {
            self.showImage=[HPGifImageView cgImageWithShow:image];
        }
        image=nil;

        dispatch_async(dispatch_get_main_queue(), ^{
           [self.layer setNeedsDisplay];
        });
        
        _gifMaxNumber=_gifMaxNumber+1;
        
        if (_gifMaxNumber>=_cacheGif.gifCount-1) {
            _gifMaxNumber=0;
            
            if (_endBlock!=nil) {
                _endBlock(_hpWeakObj);
            }
        }
        
    }
}

-(void)displayLayer:(CALayer *)layer
{
    self.layer.contents=(__bridge id _Nullable)(self.showImage.CGImage);
    self.showImage=nil;
}

+(UIImage *)cgImageWithShow:(UIImage *)image
{
    
    
    CGImageRef imageRef = image.CGImage;
    
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(imageRef);
    BOOL anyAlpha = (alpha == kCGImageAlphaFirst ||
                     alpha == kCGImageAlphaLast ||
                     alpha == kCGImageAlphaPremultipliedFirst ||
                     alpha == kCGImageAlphaPremultipliedLast);
    if (anyAlpha) {
        return image;
    }
    
    // current
    CGColorSpaceModel imageColorSpaceModel = CGColorSpaceGetModel(CGImageGetColorSpace(imageRef));
    CGColorSpaceRef colorspaceRef = CGImageGetColorSpace(imageRef);
    
    BOOL unsupportedColorSpace = (imageColorSpaceModel == kCGColorSpaceModelUnknown ||
                                  imageColorSpaceModel == kCGColorSpaceModelMonochrome ||
                                  imageColorSpaceModel == kCGColorSpaceModelCMYK ||
                                  imageColorSpaceModel == kCGColorSpaceModelIndexed);
    if (unsupportedColorSpace) {
        colorspaceRef = CGColorSpaceCreateDeviceRGB();
    }
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    
    
    // kCGImageAlphaNone is not supported in CGBitmapContextCreate.
    // Since the original image here has no alpha info, use kCGImageAlphaNoneSkipLast
    // to create bitmap graphics contexts without alpha info.
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorspaceRef,
                                                 kCGBitmapByteOrderDefault|kCGImageAlphaNoneSkipLast);
    
    if (context == nil) {
        return image;
    }
    
    // Draw the image into the context and retrieve the new bitmap image without alpha
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef imageRefWithoutAlpha = CGBitmapContextCreateImage(context);
    UIImage *imageWithoutAlpha = [UIImage imageWithCGImage:imageRefWithoutAlpha
                                                     scale:image.scale
                                               orientation:image.imageOrientation];
    
    if (unsupportedColorSpace) {
        CGColorSpaceRelease(colorspaceRef);
    }
    
    CGContextRelease(context);
    CGImageRelease(imageRefWithoutAlpha);
    return imageWithoutAlpha;
}

-(void)willMoveToWindow:(UIWindow *)newWindow
{
    if (newWindow==nil) {
        _isVisual=YES;
    }
    else
    {
        _isVisual=NO;
    }
}

-(void)hp_weakObj:(id)weakObj gifAnimationComplete:(AnimationEndBlock)completeBlock
{
    _hpWeakObj=weakObj;
    _endBlock=completeBlock;
}

- (void)startShowAnimation{
    
    self.displayLink.paused = NO;
}

-(void)pausedShowAnimation
{
    self.displayLink.paused = YES;
}

- (void)stopShowAnimation{
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

-(NSString *)loopModel
{
    if (_loopModel==nil) {
        _loopModel=NSRunLoopCommonModes;
    }
    return _loopModel;
}

- (void)hp_loadAnimatedImageWithURL:(NSURL *const)url defaultImage:(UIImage *)defaultImage;
{
    
    [self setDefaultImage:defaultImage];
    
    NSString *const filename = [HPCache md5:url.description];
    HPCacheGif * __block animatedImage = [[HPCacheGif alloc] init];
    [animatedImage hp_getCacheWithGifName:filename];
    
    if (animatedImage.cacheAnimationDic) {
        
        self.cacheGif=animatedImage;
        
    } else {
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            animatedImage = [[HPCacheGif alloc] initWithAnimatedGIFData:data cacheFileName:[NSURL URLWithString:filename]];
            if (animatedImage) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.cacheGif=animatedImage;
                    });
            }
        }] resume];
    }
}

-(void)dealloc
{

}


@end

