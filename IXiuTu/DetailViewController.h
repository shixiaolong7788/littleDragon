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

@private
    
    id<returnCelltagDelegate>   cellTagDelegate;
    id<passMiddleArrayDelegate> arrayDelegate;
    int     photoTypeIndex;
    int     photoIndex;
    NSString    *photoTypeResponsingString;
    NSMutableArray  *photoTypeArray;
    NSMutableArray  *thumbnailPicArray; //缩略图
    NSMutableArray  *middlePicArray;  //中型图片
    NSMutableArray  *photoTextArray;  //图片文字
    NSMutableArray  *profilePicArray;  //头像
    NSMutableArray  *profileNameArray;  //名字
    NSString    *photoInfoResponse;
     
}

@property (nonatomic,retain) NSMutableArray *photoTypeArray; 
@property (nonatomic,retain) NSMutableArray *thumbnailPicArray; //缩略图
@property (nonatomic,retain) NSMutableArray *middlePicArray; //中型图片
@property (nonatomic,retain) NSMutableArray *photoTextArray; //图片文字
@property (nonatomic,retain) NSMutableArray *profilePicArray; //头像
@property (nonatomic,retain) NSMutableArray *profileNameArray; //名字

@property (nonatomic,retain) NSString   *photoInfoResponse;
@property (nonatomic,retain)id<passMiddleArrayDelegate> arrayDelegate;
@property (nonatomic,retain)id<returnCelltagDelegate>   cellTagDelegate;

@end
