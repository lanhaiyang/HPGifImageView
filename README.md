# HPGifImageView

### 加载gif库

在加载高清gif内存表现稳定而且流畅

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