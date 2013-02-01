//
//  PhotoFlowView1.h
//  IXiuTu
//
//  Created by shixiaolong on 13-1-21.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIWebImageView.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "DetailViewController.h"
//#import "WaterFlowViewController.h"
#import "ThumbPhotoInfo.h"

@class WaterFlowViewController;

@protocol passScrollViewDelegate <NSObject>

- (void)loadImageView;

@end

@protocol LLWaterFlowViewDelegate;
@class LLWaterFlowCell;

@interface PhotoFlowView : UIScrollView<UIScrollViewDelegate,EGORefreshTableDelegate>{
    float y1;
    float y2;
    float y3;
    float y4;
    int _nColumns ; // 列数
    
    UIViewController     *targetVC;
    SEL                   action;
    
    
    NSMutableArray       *imageArray;
    NSMutableArray       *reuseQueue;
    
    NSMutableDictionary *_dicReuseCells; //重用的cell
    NSMutableArray *_onScreenCells; //重用的cell
    EGORefreshTableHeaderView * _refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    
	BOOL _reloading;
    id <LLWaterFlowViewDelegate> _flowdelegate;
    LLWaterFlowCell * LLCell;
    DetailViewController *detailVC;
    NSInteger currentPage;
    BOOL isDraggingEnd;
    id<passScrollViewDelegate>passScrollDelegate;
}


@property (nonatomic, retain) NSMutableDictionary *dicReuseCells;
@property (nonatomic, retain) NSMutableArray *onScreenCells;
@property (nonatomic, retain) id <LLWaterFlowViewDelegate> flowdelegate;
@property (nonatomic, retain) NSMutableArray *arrCellHeight;
@property (nonatomic, retain) NSMutableArray *arrVisibleCells;
@property (nonatomic,retain) id<passScrollViewDelegate>passScrollDelegate;

- (id)initWithFrame:(CGRect)frame target:(UIViewController*)target action:(SEL)act;
- (void)setImages:(NSArray*)images;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
- (void)setImages2:(NSArray *)images;

//获取重用的cell
- (LLWaterFlowCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

//将要移除屏幕的cell添加到可重用列表中
- (void)addCellToReuseQueue:(LLWaterFlowCell *)cell;

@end

//-------------------------------------------------------------------------------------------------------------------------------
//
//
//LLWaterFlowViewDelegate
//
//-------------------------------------------------------------------------------------------------------------------------------
@protocol LLWaterFlowViewDelegate<NSObject>

@required
- (NSUInteger)numberOfColumnsInFlowView:(PhotoFlowView *)flowView;
- (NSInteger)flowView:(PhotoFlowView *)flowView numberOfRowsInColumn:(NSInteger)column;
- (LLWaterFlowCell *)flowView:(PhotoFlowView *)flowView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)flowView:(PhotoFlowView *)flowView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)flowView:(PhotoFlowView *)flowView didSelectAtIndexPath:(NSIndexPath *)indexPath;


@end


//-------------------------------------------------------------------------------------------------------------------------------
//
//
//LLWaterFlowCell
//
//-------------------------------------------------------------------------------------------------------------------------------
@interface LLWaterFlowCell:UIWebImageView
{
	NSIndexPath *_indexPath; //位置
	NSString *_strReuseIndentifier; //重用标识
}

@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain) NSString *strReuseIndentifier;


-(id)initWithIdentifier:(NSString *)indentifier;

@end