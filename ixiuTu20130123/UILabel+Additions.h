//
//  UILabel+Additions.h
//  AppTemplate
//
//  Created by 欧然 Wu on 12-3-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(Additions)

- (id)initWithFrame:(CGRect)frame font:(UIFont*)font;
- (id)initWithFrame:(CGRect)frame textColor:(UIColor*)color;
- (id)initWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color;
- (id)initWithFrame:(CGRect)frame font:(UIFont*)font align:(UITextAlignment)align;
- (id)initWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color align:(UITextAlignment)align;
- (void)setNumberOfLines:(NSInteger)numberOfLines lineBreakMode:(UILineBreakMode)lineBreak;

@end
