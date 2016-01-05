//
//  AutoStirViewController.m
//  TOM 新闻
//
//  Created by mac on 16/1/5.
//  Copyright © 2016年 圣殿骑士团. All rights reserved.
//

#import "AutoStirViewController.h"

@interface AutoStirViewController ()

@end

#define minimum  0.3    // 图片最小缩小比例
#define maximum  4.0    // 图片最大缩小比例
#import "UIImageView+WebCache.h"
@interface AutoStirViewController ()
@property (nonatomic,assign) NSInteger tiint;
@property (nonatomic,assign) NSTimer *timer;
@property (nonatomic,strong) UILabel *lable;
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIScrollView *scroll1;
@property (nonatomic,strong) UIScrollView *scroll2;
@property (nonatomic,strong) UIImageView *imageView2;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) UIImageView *imageView1;
@property (nonatomic,strong) NSURL *url1;
@property (nonatomic,strong) UILabel  *lableNumber2;
@property (nonatomic,strong) UILabel  *lableNumber1;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;
@end
@implementation AutoStirViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.frame=self.frame ;
    // Do any additional setup after loading the view.
    
}
- (void)setViewFrame:(CGRect)viewFrame
{
    self.view.frame = viewFrame;
    if (!self.number) {
        self.number = 0;
    }
    // 背景色
    UIColor *backColor = [UIColor clearColor];
    // 底层 scroll
    self.scroll = [[UIScrollView alloc]initWithFrame:(CGRectMake(self.frame.origin.x, self.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height))];
    _scroll.backgroundColor = backColor;
    _scroll.pagingEnabled = YES; // 整页滑动
    _scroll.tag = 20202;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.contentOffset = CGPointMake(self.frame.size.width, 0); //左上角
    _scroll.contentSize   = CGSizeMake(self.frame.size.width*2, self.frame.size.height); //大小
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    
    _scroll1 = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))];
    _scroll1.backgroundColor = backColor;
    _scroll1.minimumZoomScale = minimum;
    _scroll1.maximumZoomScale = maximum;
    _scroll1.delegate = self;
    [_scroll addSubview:_scroll1];
    
    _scroll2 = [[UIScrollView alloc]initWithFrame:(CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height))];
    _scroll2.backgroundColor = backColor;
    _scroll2.minimumZoomScale = minimum;
    _scroll2.maximumZoomScale = maximum;
    _scroll2.delegate = self;
    [_scroll addSubview:_scroll2];
    
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:(CGRectMake(self.frame.origin.x, self.frame.size.height-30+self.frame.origin.y, self.frame.size.width, 30))];
    pageControl.numberOfPages = [_photoName count];
    pageControl.currentPage   =  _number;
    pageControl.tag = 10101;
    if (self.needPage == NO) {
        pageControl.pageIndicatorTintColor = [UIColor clearColor]; // 点的背景色
        pageControl.currentPageIndicatorTintColor = [UIColor clearColor]; // 当前点的颜色
    }else{
        pageControl.pageIndicatorTintColor = [UIColor grayColor]; // 点的背景色
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor]; // 当前点的颜色
    }
    [pageControl addTarget:self action:@selector(asdf:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:pageControl];
    
    [self.view addSubview:_lable];
    
    if (_number == 0) { // 加载起始图片
        [self fangfaAa:[_photoName count] - 1 bb:_number];
    }else{
        [self fangfaAa:_number - 1 bb:_number];
    }
    [self startTimer];
    //设置手势识别器,单击
    UITapGestureRecognizer *oneFingerOneTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerOneTaps)] ;
    [[self view] addGestureRecognizer:oneFingerOneTaps];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)oneFingerOneTaps
{
    [self.delegateLunbo pusSomeViewConllerWithTag:_number];
}
//开始拖动时
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.needTimer == YES && self.photoName.count>1) {
        [_timer invalidate];
        // 重复开始关键
        _timer = nil; // 赋空之后即释放
    }
}
- (void)startTimer
{
    if (self.needTimer == YES && self.photoName.count>1) {
        NSTimeInterval timeInterval =2.0 ;//时间间隔
        _tiint = _number;
        _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(handleMaxShowTimer:)userInfo:nil repeats:YES];
    }
}
//结束拖动时
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
- (void)handleMaxShowTimer:(NSTimer*)showtime
{
    if (_tiint == [_photoName count]) {
        _tiint = 0;
    }else{
        _tiint++;}
    [self changeScroll:(UIScrollView *)[self.view viewWithTag:20202]];
}
- (void)asdf:(UIPageControl*)page
{  // 调用方法重新加载图片
    [self changeScroll:(UIScrollView *)[self.view viewWithTag:20202]];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{  // 决定那个子视图可以被缩放
    return [scrollView subviews][0];
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2)
{  // 图片缩放时保持中心点
    ((UIScrollView *)[scrollView subviews][0]).center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{  // 滑动时调用方法重新加载图片
    if (_photoName.count>1) {
        [self changeScroll:scrollView];
    }
}
- (void)changeScroll:(UIScrollView *)scrollView
{   // 重新加载图片
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:10101];
    int a = (int)[_photoName count] - 1 ;
    
    if (scrollView.tag == 20202 ) {
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        if (pageControl.currentPage < _number) {
            [scrollView setContentOffset:(CGPointMake(0, 0)) animated:YES];
            pageControl.currentPage = _number;
        }
        if (contentOffsetX <= 0 ) {
            if (_number == 0) {
                [self fangfaAa:a-1 bb:a];
                _tiint=pageControl.currentPage = _number = a;
            }else if (_number == 1){
                [self fangfaAa:a bb:0];
                _tiint=pageControl.currentPage = _number = 0;
            }else{
                [self fangfaAa:_number-2 bb:_number-1];
                _tiint=pageControl.currentPage = --_number;
            }
            if (contentOffsetX <= 0) {
                scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
            }
        }
        if (contentOffsetX > self.frame.size.width|| pageControl.currentPage > _number || _tiint > _number) {
            if (_number == a) {
                [self fangfaAa:a bb:0];
                _tiint= pageControl.currentPage = _number = 0;
            }else{
                [self fangfaAa:_number bb:_number+1];
                _tiint=pageControl.currentPage = ++_number;
            }
            if (contentOffsetX > self.frame.size.width ) {
                scrollView.contentOffset = CGPointMake(1, 0);
            } else {
                scrollView.contentOffset = CGPointMake(1, 0);
                [scrollView setContentOffset:(CGPointMake(self.frame.size.width, 0)) animated:YES];
            }
        }
    }
}

- (void)fangfaAa:(NSInteger)aa bb:(NSInteger)bb
{
    if (_photoName.count == 1) {
        _scroll.contentSize   = CGSizeMake(self.frame.size.width, self.frame.size.height); //大小
    }
    if (self.photoName.count >= aa && self.photoName.count >= bb) {

        if (!_imageView2) {
            _imageView2 = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))]; // 照片尺寸  进行了伸缩
            [_scroll1 addSubview:_imageView2];
        }
        _url = [NSURL URLWithString:_photoName[aa]];// url 图片链接
        
        if (!_imageView1) {
            _imageView1 = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))];// 照片尺寸  进行了伸缩
            [_scroll2 addSubview:_imageView1];
        } //imageView1.center = self.view.center;
        _url1 = [NSURL URLWithString:_photoName[bb]];// url 图片链接
        
        if (!_lableNumber1) {
            _lableNumber1 = [[UILabel alloc]initWithFrame:(CGRectMake(self.frame.size.width-60,_imageView2.frame.size.height-40, 60, 30))];// 数字标签
            _lableNumber1.backgroundColor = [UIColor clearColor];
            _lableNumber1.font = [UIFont systemFontOfSize:22];
            [_scroll1 addSubview:_lableNumber1];
        }
        NSString *string = [NSString stringWithFormat:@"%ld/%lu",aa+1,(unsigned long)[_photoName count]];
        _lableNumber1.text = string;
        
        if (!_lableNumber2) {
            _lableNumber2 = [[UILabel alloc]initWithFrame:(CGRectMake(self.frame.size.width-60,_imageView1.frame.size.height-40, 60, 30))];// 数字标签
            _lableNumber2.backgroundColor = [UIColor clearColor];
            _lableNumber2.font = [UIFont systemFontOfSize:22];
            [_scroll2 addSubview:_lableNumber2];
        }
        NSString *string2 = [NSString stringWithFormat:@"%ld/%lu",bb+1,(unsigned long)[_photoName count]];
        _lableNumber2.text = string2;
    }
    
    
    if (self.photoStrings.count>=aa && self.photoStrings.count >= bb) {
        if (!_label1) {
            _label1 = [[UILabel alloc]initWithFrame:(CGRectMake(20,_imageView2.frame.size.height-40, self.frame.size.width-80, 30))];
            _label1.textColor = [UIColor whiteColor];
            _label2 = [[UILabel alloc]initWithFrame:(CGRectMake(20,_imageView1.frame.size.height-40, self.frame.size.width-80, 30))];
            _label2.textColor = [UIColor whiteColor];
            [_imageView2 addSubview:_label1];
            [_imageView1 addSubview:_label2];
        }
        _label1.text = _photoStrings[aa];
        _label2.text = _photoStrings[bb];
    }
    
    if (self.textArray.count>=aa && self.textArray.count >= bb) {
        if (!_label3) {
            _label3 = [[UILabel alloc]initWithFrame:(CGRectMake(20,_imageView2.frame.size.height+15, 300, [self heightForSteing:self.textArray[aa] font:16]))];
            _label3.textColor = [UIColor whiteColor];
            _label3.numberOfLines = 0;
            _label3.font = [UIFont systemFontOfSize:16];
            _label3.textAlignment = NSTextAlignmentLeft;
            _label4 = [[UILabel alloc]initWithFrame:(CGRectMake(20,_imageView1.frame.size.height+15, 300,  [self heightForSteing:self.textArray[bb] font:16]))];
            _label4.textColor = [UIColor whiteColor];
            _label4.numberOfLines = 0;
            _label4.font = [UIFont systemFontOfSize:16];
            _label4.textAlignment = NSTextAlignmentLeft;
            [_scroll1 addSubview:_label3];
            [_scroll2 addSubview:_label4];
        }
        _label3.text = self.textArray[aa];
        _label4.text = self.textArray[bb];
    }
    if (self.autophotoSize == NO) {
        [_imageView2 sd_setImageWithURL:_url]; // 给他一个网络图片
    }else {
        [_imageView2 sd_setImageWithURL:_url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGFloat bili = _imageView2.image.size.height/_imageView2.image.size.width;
            CGFloat gao = (1-self.frame.size.width*bili/self.view.frame.size.height)/2*0.7*self.view.frame.size.height;
            CGFloat scrollGao = 0;
            _imageView2.frame = CGRectMake(0, gao, self.frame.size.width, self.frame.size.width*bili);
            _lableNumber1.frame = CGRectMake(self.frame.size.width-60,gao+_imageView2.frame.size.height-40, 60, 30);
            scrollGao = gao + self.frame.size.width*bili;
            if (self.photoStrings.count>=aa && self.photoStrings.count >= bb) {
                _label1.frame = CGRectMake(20,_imageView2.frame.size.height-40, self.frame.size.width-80, 30);
            }
            if (self.textArray.count>=aa && self.textArray.count >= bb) {
                _label3.frame = CGRectMake(20,gao+_imageView2.frame.size.height+15, 300, [self heightForSteing:self.textArray[aa] font:16]);
                scrollGao = scrollGao + 15 + _label3.frame.size.height;
            }
            _scroll1.contentSize   = CGSizeMake(self.frame.size.width, scrollGao+15); //大小
        }];
    }
    if (self.autophotoSize == NO) {
        [_imageView1 sd_setImageWithURL:_url1]; // 给他一个网络图片
    }else {
        [_imageView1 sd_setImageWithURL:_url1 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGFloat bili = _imageView1.image.size.height/_imageView1.image.size.width;
            CGFloat gao = (1-self.frame.size.width*bili/self.view.frame.size.height)/2*0.7*self.view.frame.size.height;
            CGFloat scrollGao = 0;
            _imageView1.frame = CGRectMake(0, gao, self.frame.size.width, self.frame.size.width*bili);
            _lableNumber2.frame = CGRectMake(self.frame.size.width-60,gao+_imageView1.frame.size.height-40, 60, 30);
            scrollGao = gao + self.frame.size.width*bili;
            if (self.photoStrings.count>=aa && self.photoStrings.count >= bb) {
                _label2.frame = CGRectMake(20,_imageView1.frame.size.height-40, self.frame.size.width-80, 30);
            }
            if (self.textArray.count>=aa && self.textArray.count >= bb) {
                _label4.frame = CGRectMake(20,gao+_imageView1.frame.size.height+15, 300, [self heightForSteing:self.textArray[bb] font:16]);
                scrollGao = scrollGao + 15 + _label4.frame.size.height;
            }
            _scroll2.contentSize   = CGSizeMake(self.frame.size.width, scrollGao+15); //大小
        }];
    }
}
#pragma mark- 自适应高度
- (CGFloat)heightForSteing:(NSString*)str font:(NSInteger)font
{
    // 获取字体属性(字体样式,字体大小,行高等等),用 字典存储 key 值为 NSFontAttributeName
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName ,nil];
    //2.根据字符串 str 绘制一个矩形
    CGRect bound = [str boundingRectWithSize:(CGSizeMake(300, 90000)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return bound.size.height;
}


@end

