//
//  WaterFlowViewController.h
//  IXiuTu
//
//  Created by shixiaolong on 13-1-16.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoFlowView.h"
#import "DetailViewController.h"
//#import "BaseViewController.h"

typedef void (^RevealBlock)();

@protocol returnButtonTagDelegate <NSObject>

- (NSInteger)returnButtonTag;
- (NSString *)returnButtonTitle;

@end

@interface WaterFlowViewController : UIViewController<LLWaterFlowViewDelegate,passMiddleArrayDelegate,passActiVityViewDelegate>
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
    
    NSMutableArray *photoTypeArray;  //图片类型
    NSMutableArray *thumbnailPicArray; //缩略图片
    NSMutableArray *middlePicArray; //原图
    NSMutableArray *photoTextArray; //图片的文字
    NSMutableArray *profilePicArray; //头像图片
    NSMutableArray *profileNameArray; //名字
    
    NSMutableArray *middlePicArrayImg;
    NSString *photoInfoResponse;
    DetailViewController *detailVC;
    UIActivityIndicatorView *activityView;
}

@property (nonatomic,retain)id<returnButtonTagDelegate>tagDelegate;
@property (nonatomic,retain)NSMutableArray *photoTypeArray;  //图片类型
@property (nonatomic,retain)NSMutableArray *thumbnailPicArray; //缩略图
@property (nonatomic,retain)NSMutableArray *middlePicArray;  //原图
@property (nonatomic,retain)NSMutableArray *photoTextArray; //图片的文字
@property (nonatomic,retain)NSMutableArray *profilePicArray; //头像图片
@property (nonatomic,retain)NSMutableArray *profileNameArray; //名字

@property (nonatomic,retain)NSString *photoInfoResponse;
@property (nonatomic,retain)NSMutableArray *middlePicArrayImg;

- (void)getPhotoType;
- (void)getPhotoClasstype:(NSString *)classType page:(NSString *)page;
- (void)photoInfoParser;

//add by caijunjie
//2013-01-17
//增加返回代理
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock;

@end
