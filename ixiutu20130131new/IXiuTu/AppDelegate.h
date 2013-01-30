//
//  AppDelegate.h
//  IXiuTu
//
//  Created by shixiaolong on 13-1-14.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoInfoPaser.h"
#import "MainViewController.h"
#import "WaterFlowViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSArray *classtype; //记录主题分类
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSArray *classtype;

- (void) getClassType;

@end
