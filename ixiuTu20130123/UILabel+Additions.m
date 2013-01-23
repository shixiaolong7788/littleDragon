//
//  UILabel+Additions.m
//  AppTemplate
//
//  Created by 欧然 Wu on 12-3-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UILabel+Additions.h"

@implementation UILabel(Additions)

- (id)initWithFrame:(CGRect)frame font:(UIFont*)font{
    return [self initWithFrame:frame font:font textColor:nil align:UITextAlignmentLeft];
}
- (id)initWithFrame:(CGRect)frame textColor:(UIColor*)color{
    return [self initWithFrame:frame font:nil textColor:color align:UITextAlignmentLeft];
}
- (id)initWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color{
    return [self initWithFrame:frame font:font textColor:color align:UITextAlignmentLeft];
}
- (id)initWithFrame:(CGRect)frame font:(UIFont*)font align:(UITextAlignment)align{
    return [self initWithFrame:frame font:font textColor:nil align:align];
}
- (id)initWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color align:(UITextAlignment)align{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if (font) {
            self.font = font;
        }
        if (color) {
            self.textColor = color;
        }
        if (align) {
            self.textAlignment = align;
        }
    }
    return self;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines lineBreakMode:(UILineBreakMode)lineBreak{
    self.numberOfLines = numberOfLines;
    self.lineBreakMode = lineBreak;
}


@end
