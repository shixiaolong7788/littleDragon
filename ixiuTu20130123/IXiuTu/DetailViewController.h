//
//  DetailViewController.h
//  IXiuTu
//
//  Created by shixiaolong on 13-1-22.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"

@protocol passMiddleArrayDelegate <NSObject>

- (NSMutableArray *)returnMiddlepicarray;

@end

@protocol returnCelltagDelegate <NSObject>

- (int)returnCelltag;

@end

@interface DetailViewController : UIViewController
{
    id<returnCelltagDelegate>cellTagDelegate;
    id<passMiddleArrayDelegate>arrayDelegate;
    int photoTypeIndex;
    int photoIndex;
    NSString *photoTypeResponsingString;
    NSMutableArray *photoTypeArray;
    NSMutableArray *thumbnailPicArray;
    NSMutableArray *middlePicArray;
    NSString *photoInfoResponse;
    UIImageView *middleImageview;
}

@property (nonatomic,retain)NSMutableArray *photoTypeArray;
@property (nonatomic,retain)NSMutableArray *thumbnailPicArray;
@property (nonatomic,retain)NSMutableArray *middlePicArray;
@property (nonatomic,retain)NSString *photoInfoResponse;
@property (nonatomic,retain)id<passMiddleArrayDelegate>arrayDelegate;
@property (nonatomic,retain)id<returnCelltagDelegate>cellTagDelegate;

@end
