//
//  MainViewController.h
//  IXiuTu
//
//  Created by shixiaolong on 13-1-15.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowViewController.h"

@interface MainViewController : UIViewController<returnButtonTagDelegate>
{
    UIButton *typeButton;
    WaterFlowViewController *waterFlow;
    UINavigationController *waterFlowNav;
}

@end
