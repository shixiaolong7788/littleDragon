//
//  UILabel+Additions.h
//  AppTemplate
//
//  Created by 欧然 Wu on 12-3-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UILabel+Additions.h"
#import "UIButton+Additions.h"
#import "UIWebImageView.h"


#define WTisRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
