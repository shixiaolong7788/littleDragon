//
//  ICommentView.h
//  IXiuTu
//
//  Created by vbarter on 13-1-27.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICommentView : UIView
{
@private
    NSString *sName;
    NSString *sComment;
    NSString *sImgUrl;
    IBOutlet UIImageView *logo;
    IBOutlet UILabel *name;
    IBOutlet UITextView *comment;
    
    
}

@property(nonatomic, retain) UIImageView *logo;
@property(nonatomic, retain) UILabel *name;
@property(nonatomic, retain) UITextView *comment;
@property(nonatomic, retain) NSString *sName;
@property(nonatomic, retain) NSString *sComment;
@property(nonatomic, retain) NSString *sImgUrl;


- (UIImage *)scaleImage:(UIImage*)img toSize:(CGSize)size;

@end
