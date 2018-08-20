# HPGifImageView

### 加载gif库

在加载高清gif内存表现稳定而且流畅

```
HPCacheGif
	|_ HPCache (缓存工具类)
	|_ HPCacheImage (缓存图片)
	|_ HPGifCacheManage (管理缓存)

HPGifImageView
	|_ HPCacheGif (缓存gif)
	|_ HPGifCacheManage
	|_ HPImageCompress (压缩)

```

### 加载网络获取gif

```objective-c
    HPGifImageView *gifImageVIew4=[[HPGifImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [gifImageVIew4 hp_loadAnimatedImageWithURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"] defaultImage:nil];
    [self.view addSubview:gifImageVIew4];

```
### 加载本地gif

```objective-c
    HPCacheGif *cacheGif=[[HPCacheGif alloc] init];
    [cacheGif hp_cacheWithGifName:@"kissAnimation"];
    
    HPGifImageView *gifImageView=[[HPGifImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    gifImageView.cacheGif=cacheGif;
    [self.view addSubview:gifImageView];

```

### 注意在网页看git会有些卡顿请下载下来在模拟器运行

<p align="center" >
  <img src="https://github.com/lanhaiyang/HPGifImageView/blob/master/README/Result.gif" alt="效果" title="效果">
</p>

<p align="center" >
  <img src="https://github.com/lanhaiyang/HPGifImageView/blob/master/README/Memory.gif" alt="内存" title="内存">
</p>