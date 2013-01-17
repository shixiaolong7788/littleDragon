//
//  UIWebImageView.h
//  AppTemplate
//
//  Created by 欧然 Wu on 12-3-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Additions.h"
#import "MKNetworkEngine.h"
#import "MKNetworkKit.h"
#import "MKNetworkOperation.h"
typedef enum {
    VMUIWebImageStyleScale,     //按比例
    VMUIWebImageStyleCut,       //裁剪
    VMUIWebImageStyleStretch,   //拉伸
    VMUIWebImageStyleTopLeft    //左上角
} VMUIWebImageStyle;

@interface UIWebImageView : UIImageView{
    VMUIWebImageStyle    _style;
    MKNetworkOperation   *op;
}

@property (strong, nonatomic) MKNetworkEngine *engine;

- (id)initWithFrame:(CGRect)frame urlPath:(NSString*)urlPath;
- (id)initWithFrame:(CGRect)frame urlPath:(NSString*)urlPath style:(VMUIWebImageStyle) style;
- (void)loadImageWithUrl:(NSString*)url;

@end
