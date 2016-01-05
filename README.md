# autostir
轮播图
一.  一个类解决对于轮播图的多种需求,这个类可以提供多种轮播图的样式:
1.照片下方的说明文字标题(可选)
2.从第几个图片开始播放
3.轮播范围大小(整个轮播区域的大小)
4.点击事件的协议,返回第几个图片被点击
5.是否需要小圆点
6.是否需要自动轮播
7.固定图片大小(可选)
8.图片的相关文字,在图片下方(可谁图片上下滑动查看全部文字)
9.是否需要根据图片自动改变大小

二. 注意
这个类是基于SDWebImage的,注意先加入SDWebImage.

三. 使用示例

AutoStirViewController *temp = [[AutoStirViewController alloc]init];

NSMutableArray *photoArray = [NSMutableArray array];// 图片加载url数组

NSMutableArray *stringArray = [NSMutableArray array];// 图片标题数组

NSMutableArray *textArray = [NSMutableArray array];// 图片描述文字数组

for (NSDictionary *modelDic in self.model.slides) { // 从modle里取数据

[photoArray addObject:modelDic[@"image"]];

[stringArray addObject:modelDic[@"title"]];

[textArray addObject:modelDic[@"description"]];

}

temp.photoName = photoArray; 

temp.photoStrings = stringArray;

temp.textArray = textArray;

temp.number = 0; // 从第0张开始播放

temp.needTimer = NO; // 不自动滚动

temp.autophotoSize = YES;// 图片根据自身大小自适应

CGFloat width = [[UIScreen mainScreen]bounds].size.width;

CGFloat height = [[UIScreen mainScreen]bounds].size.height;

temp.frame = CGRectMake(0, 0, width, width*0.56);// 图片默认大小

temp.viewFrame = CGRectMake(0, 0, width, [[UIScreen mainScreen]bounds].size.height);// 整个轮播视图的大小,含描述文字所占空间

[self.view addSubview:temp.view];

[self addChildViewController:temp];
