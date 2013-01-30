//
//  UIImage+Additions.h
//  AppTemplate
//
//  Created by 欧然 Wu on 12-3-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

@interface UIImage (UIImage_Additions)

-(UIImage*) scaleImagetoSize:(CGSize) size;

-(UIImage*) cutImagetoSize:(CGSize) size;

-(UIImage*) stretchImagetoSize:(CGSize) size;

-(UIImage*) topLeftImagetoSize:(CGSize) size;

-(UIImage*) grayImage;

@end
