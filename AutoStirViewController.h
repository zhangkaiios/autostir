//
//  AutoStirViewController.h
//  TOM 新闻
//
//  Created by mac on 16/1/5.
//  Copyright © 2016年 圣殿骑士团. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol lunBoDelegate1<NSObject>
- (void)pusSomeViewConllerWithTag:(NSInteger)tag;
@end

@interface AutoStirViewController : UIViewController<UIScrollViewDelegate>
/**照片的网址数组*/
@property (nonatomic,strong) NSArray      *photoName;
/**照片下方的说明文字数组*/
@property (nonatomic,retain) NSArray      *photoStrings;
/**从第几个图片开始播放*/
@property (nonatomic,assign) NSUInteger   number;
/**轮播范围大小*/
@property (nonatomic,assign) CGRect        frame;
/**点击事件的协议,返回第几个图片被点击*/
@property (nonatomic,assign) id<lunBoDelegate1>delegateLunbo;
/**是否需要小圆点*/
@property (nonatomic,assign) BOOL      needPage;
/**是否需要自动轮播*/
@property (nonatomic,assign) BOOL      needTimer;
/**图片的 frame*/
@property (nonatomic, assign) CGRect viewFrame;
/** 图片的相关文字,在图片下方*/
@property (nonatomic, copy)  NSArray *textArray;
/**是否需要根据图片自动改变大小*/
@property (nonatomic, assign) BOOL autophotoSize;
@end