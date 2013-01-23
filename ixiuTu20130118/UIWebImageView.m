//
//  UIWebImageView.m
//  AppTemplate
//
//  Created by 欧然 Wu on 12-3-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIWebImageView.h"

@implementation UIWebImageView
@synthesize engine = _engine;

- (void)loadImageWithUrl:(NSString*)url{
    [op cancel];
    op = [_engine operationWithURLString:url];
    //set completion and error blocks
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        UIImage* image = [op responseImage];
         CGSize size = isRetina ? CGSizeMake(self.frame.size.width * 2, self.frame.size.height * 2) : self.frame.size;
        switch (_style) {
            case VMUIWebImageStyleScale:
                image = [image scaleImagetoSize:size];
                break;
            case VMUIWebImageStyleCut: 
                image = [image cutImagetoSize:size];
                break;
            case VMUIWebImageStyleStretch:
                image = [image stretchImagetoSize:size];
                break;
            case VMUIWebImageStyleTopLeft:
                image = [image topLeftImagetoSize:size];
                break;
        }
        self.image = image;
    } onError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    [_engine enqueueOperation: op];
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame urlPath:nil style:VMUIWebImageStyleScale];
}

- (id)initWithFrame:(CGRect)frame urlPath:(NSString*)urlPath
{
    return [self initWithFrame:frame urlPath:urlPath style:VMUIWebImageStyleScale];
}
- (id)initWithFrame:(CGRect)frame urlPath:(NSString*)urlPath style:(VMUIWebImageStyle) style{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        _style = style;
        _engine = [[MKNetworkEngine alloc] initWithHostName:@"" customHeaderFields:nil];
        [self loadImageWithUrl:urlPath];
    }
    return self;
}
@end
