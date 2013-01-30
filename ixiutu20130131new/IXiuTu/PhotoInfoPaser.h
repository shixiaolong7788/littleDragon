//
//  PhotoInfoPaser.h
//  IXiuTu
//
//  Created by shixiaolong on 13-1-14.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "ASIFormDataRequest.h"
#import "WaterFlowViewController.h"
@interface PhotoInfoPaser : UIViewController<NSURLConnectionDelegate,ASIHTTPRequestDelegate,NSURLConnectionDataDelegate>
{
    
    int photoTypeIndex;
    int photoIndex;
    NSString *photoTypeResponsingString;
    NSMutableArray *photoTypeArray;
    NSMutableArray *thumbnailPicArray;
    NSMutableArray *middlePicArray;
    NSString *photoInfoResponse;
}


@property (nonatomic,retain)NSMutableArray *photoTypeArray;
@property (nonatomic,retain)NSMutableArray *thumbnailPicArray;
@property (nonatomic,retain)NSMutableArray *middlePicArray;
@property (nonatomic,retain)NSString *photoInfoResponse;

- (void)getPhotoType;
- (void)getPhotoClasstype:(NSString *)classType page:(NSString *)page;
- (void)photoInfoParser;
+ (id) sharedInstance;

@end
