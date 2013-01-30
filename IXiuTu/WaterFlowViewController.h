//
//  WaterFlowViewController.h
//  IXiuTu
//
//  Created by shixiaolong on 13-1-16.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoFlowView.h"
//#import "BaseViewController.h"

typedef void (^RevealBlock)();

@protocol returnButtonTagDelegate <NSObject>

- (NSInteger)returnButtonTag;
- (NSString *)returnButtonTitle;

@end

@interface WaterFlowViewController : UIViewController
{
    //add by caijunjie
    //2013-01-17
    //增加返回代理
@private
	RevealBlock _revealBlock;
    
    id<returnButtonTagDelegate>tagDelegate;
    int photoTypeIndex;
    int photoIndex;
    NSString *photoTypeResponsingString;
    NSMutableArray *photoTypeArray;
    NSMutableArray *thumbnailPicArray;
    NSMutableArray *middlePicArray;
    NSString *photoInfoResponse;
}

@property (nonatomic,retain)id<returnButtonTagDelegate>tagDelegate;
@property (nonatomic,retain)NSMutableArray *photoTypeArray;
@property (nonatomic,retain)NSMutableArray *thumbnailPicArray;
@property (nonatomic,retain)NSMutableArray *middlePicArray;
@property (nonatomic,retain)NSString *photoInfoResponse;

- (void)getPhotoType;
- (void)getPhotoClasstype:(NSString *)classType page:(NSString *)page;
- (void)photoInfoParser;

//add by caijunjie
//2013-01-17
//增加返回代理
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock;

@end
