//
//  PhotoFlowView.m
//  KuXiang
//
//  Created by 欧然 Wu on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PhotoFlowView.h"

@implementation PhotoFlowView
@synthesize dicReuseCells = _dicReuseCells, onScreenCells = _onScreenCells;
- (id)initWithFrame:(CGRect)frame target:(UIViewController*)target action:(SEL)act
{
    self = [super initWithFrame:frame];
    if (self) {
        targetVC = target;
        action   = act;
        self.delegate = self;
    }
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView * view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        view.delegate = self;
        [self addSubview:view];
        _refreshHeaderView = view;
        //        [view release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];

    return self;
}


//获取重用的cell
- (LLWaterFlowCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier{
	if(identifier == nil || identifier.length ==0)return nil;
    
	NSMutableArray *arrIndentifier_ = [_dicReuseCells objectForKey:identifier];
	if(arrIndentifier_ && [arrIndentifier_ isKindOfClass:[NSArray class]] && arrIndentifier_.count > 0){
		//找到了重用的 
		LLWaterFlowCell *cell_ = [arrIndentifier_ lastObject];
		[arrIndentifier_ removeLastObject];
		return cell_;
	}
	return nil;
}

//将要移除屏幕的cell添加到可重用列表中
- (void)addCellToReuseQueue:(LLWaterFlowCell *)cell
{
	if(cell.strReuseIndentifier.length == 0) return ;
	
	if(self.dicReuseCells == nil){
		self.dicReuseCells = [NSMutableDictionary dictionaryWithCapacity:3];
		NSMutableArray *arr_ = [NSMutableArray arrayWithObject:cell];
		[_dicReuseCells setObject:arr_ forKey:cell.strReuseIndentifier];
	}else
    {
		NSMutableArray *arr_ = [_dicReuseCells objectForKey:cell.strReuseIndentifier];
		if(arr_ == nil){
			arr_ = [NSMutableArray arrayWithObject:cell];
			[_dicReuseCells setObject:arr_ forKey:cell.strReuseIndentifier];
		}
		else {
			[arr_ addObject:cell];
		}
	}
}

- (void)setImages:(NSArray*)images{
    _onScreenCells = [NSMutableArray array];
    float offsetY = 4;
    if (images) {
        if (!imageArray) imageArray = [NSMutableArray array];
        y1 = offsetY; y2 = offsetY; y3 = offsetY;        
        for (NSArray *arr in images) {
            //find the smallest y in y1, y2, y3, y4
            float tempY = y1; int caseValue = 0;
            if (tempY>y2) { tempY = y2; caseValue = 1; }
            if (tempY>y3) { tempY = y3; caseValue = 2; }
            
            float h = [[arr objectAtIndex:0] floatValue];
            int   x = 5 + caseValue%3*105;
            float y = 0;
            switch (caseValue) {
                case 0:
                    y = y1; y1 = y1 + h +4;
                    break;  
                case 1:
                    y = y2; y2 = y2+ h + 4;
                    break;
                case 2:
                    y = y3; y3 = y3 + h + 4;
                    break;
                default:
                    break;
            }

            [imageArray addObject:[NSArray arrayWithObjects:[NSNumber numberWithFloat:x], [NSNumber numberWithFloat:y], [NSNumber numberWithFloat:h], [arr objectAtIndex:1], nil]];
            if (y1 > self.frame.size.height && y2 > self.frame.size.height && y3 > self.frame.size.height) continue;
            
            LLWaterFlowCell* imageView;
            imageView = [[LLWaterFlowCell alloc] initWithIdentifier:@"LLWaterFlowCell_Identifier"];
            [imageView setFrame:CGRectMake(x, y, 100, h)];
            imageView.tag = 100+[images indexOfObject:arr];
            [imageView loadImageWithUrl:[arr objectAtIndex:1]];
            [self addSubview:imageView];
            [imageView setUserInteractionEnabled:YES];
            imageView.backgroundColor = [UIColor blackColor];//保证在图片未加载出来之前能接受滑动手势
            imageView.layer.borderWidth = 2;
            imageView.layer.borderColor = [UIColor whiteColor].CGColor;
            
            UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:targetVC action:action];
            [imageView addGestureRecognizer:tapOne];
            [_onScreenCells addObject:imageView];
        }
        float tempY = y1;
        if (tempY<y2) tempY = y2;
        if (tempY<y3) tempY = y3;
        
        [self setContentSize:CGSizeMake(self.frame.size.width, (tempY > self.frame.size.height ? tempY : self.frame.size.height+1))];
    }
    NSLog(@"init [self.onScreenCells count]: %d",[self.onScreenCells count]);

}


- (void)reloadImageViews{
    CGPoint offset = self.contentOffset;
    if (!reuseQueue) {
        reuseQueue = [NSMutableArray array];
    }
    //移掉划出屏幕外的图片
    NSMutableArray *readyToRemove = [NSMutableArray array];
    for (LLWaterFlowCell *view in _onScreenCells) {
        if((view.frame.origin.y + view.frame.size.height  - offset.y) <  0.0001 || (view.frame.origin.y - self.frame.size.height - offset.y) > 0.0001){
            [readyToRemove addObject:view];
        }
    }
    for (LLWaterFlowCell *view in readyToRemove) {
        [_onScreenCells removeObject:view];
        [view removeFromSuperview];
        [self addCellToReuseQueue:view];
    }
    //遍历图片数组
    for (NSArray *imageInfo in imageArray) { 
        int   tagIndex = [imageArray indexOfObject:imageInfo];
        float imageX = [[imageInfo objectAtIndex:0] floatValue];
        float imageY = [[imageInfo objectAtIndex:1] floatValue];
        float imageYH = imageY + [[imageInfo objectAtIndex:2] floatValue];
        
        BOOL OnScreen = FALSE;
        if (imageY <= offset.y && imageYH >= offset.y) OnScreen = TRUE;
        if (imageY >= offset.y && imageY <= (offset.y + self.frame.size.height)) OnScreen = TRUE;
        //在屏幕范围内的创建添加
        if (OnScreen) {
            BOOL HasOnScreen = FALSE;
            for (LLWaterFlowCell *vi in _onScreenCells) {
                if (tagIndex+100 == vi.tag)HasOnScreen = TRUE;
            }
            if (!HasOnScreen) {
                LLWaterFlowCell *imageView = [self dequeueReusableCellWithIdentifier:@"LLWaterFlowCell_Identifier"];
                if(imageView == nil)
                {
                    imageView  = [[LLWaterFlowCell alloc] initWithIdentifier:@"LLWaterFlowCell_Identifier"];
                    [imageView setUserInteractionEnabled:YES];
                    imageView.backgroundColor = [UIColor blackColor];//保证在图片未加载出来之前能接受滑动手势
                    imageView.layer.borderWidth = 2;
                    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
                    
                    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:targetVC action:action];
                    [imageView addGestureRecognizer:tapOne];
                }
                else 
                {
                    //NSLog(@"此条是从重用列表中获取的。。。。。");
                    [imageView setImage:nil];
                }
                [imageView setFrame:CGRectMake(imageX, imageY, 100, imageYH-imageY)];
                imageView.tag = tagIndex+100;
                [imageView loadImageWithUrl:[imageInfo objectAtIndex:3]];
                [self addSubview:imageView];
                [_onScreenCells addObject:imageView];
            }
        }
    }

}


//- (void)ImageTaped:(UITapGestureRecognizer*)UITapGestureRecognizer
//{
//    UIView* cellView = UITapGestureRecognizer.view;
//    LLWaterFlowCell * cell = (LLWaterFlowCell *)cellView;
//    if([_flowdelegate respondsToSelector:@selector(flowView:didSelectAtIndexPath:)]){
//        [_flowdelegate flowView:self didSelectAtIndexPath:cell.indexPath];
//    }
//}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self reloadImageViews];
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	[self reloadImageViews];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"[self.dicReuseCells count]: %d",[self.dicReuseCells count]);
//    NSLog(@"[self.onScreenCells count]: %d",[self.onScreenCells count]);
//    NSLog(@"[self.subviews count]: %d",[self.subviews count]);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}
@end

//-------------------------------------------------------------------------------------------------------------------------------
//
//
//LLWaterFlowCell
//
//-------------------------------------------------------------------------------------------------------------------------------
@implementation LLWaterFlowCell
@synthesize indexPath = _indexPath;
@synthesize strReuseIndentifier = _strReuseIndentifier;

-(id)initWithIdentifier:(NSString *)indentifier
{
	if(self = [super init])
	{
		self.strReuseIndentifier = indentifier;
	}
	
	return self;
}

@end
