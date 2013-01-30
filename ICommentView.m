//
//  ICommentView.m
//  IXiuTu
//
//  Created by vbarter on 13-1-27.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import "ICommentView.h"
#import "QuartzCore/QuartzCore.h"

@implementation ICommentView

@synthesize logo = _logo;
@synthesize name = _name;
@synthesize comment = _comment;
@synthesize sName = _sName;
@synthesize sComment = _sComment;
@synthesize sImgUrl = _sImgUrl;

- (UIImage *)scaleImage:(UIImage*)img toSize:(CGSize)size
{
    
    // 把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    NSLog(@"%f %f",scaledImage.size.height,scaledImage.size.width);
    return scaledImage;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"imgurl: %@",self.sImgUrl);
    NSLog(@"name: %@",self.sName);
    NSLog(@"comment: %@",self.sComment);
    double imageSize = 80;
    logo.clipsToBounds = NO;
    NSURL *url = [NSURL URLWithString:self.sImgUrl];
    NSLog(@"我拿到了 %@",url);
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:data];
    UIImage *image = [self scaleImage:img toSize:CGSizeMake(imageSize, imageSize)];
    logo = [[UIImageView alloc] initWithFrame:CGRectMake(20, -40, imageSize,imageSize)];
    [logo setImage:image];
    NSLog(@"width: %f",logo.image.size.width);
    NSLog(@"height: %f",logo.image.size.height);
    logo.layer.cornerRadius = image.size.height / 2;
    logo.layer.masksToBounds = YES;
    [self addSubview:logo];
    self.name.text = self.sName; 
    self.comment.text = self.sComment;
    
    
    //TODO
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"ThumbnailGridView:awakeFromNib");
}

- (void) dealloc
{
    [super dealloc];
}

@end
