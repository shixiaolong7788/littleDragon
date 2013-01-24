//
//  DetailViewController.m
//  IXiuTu
//
//  Created by shixiaolong on 13-1-22.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import "DetailViewController.h"
#import "MDCParallaxView.h"

@interface DetailViewController () <UIScrollViewDelegate>

@end

@implementation DetailViewController


@synthesize photoTypeArray = _photoTypeArray;
@synthesize thumbnailPicArray = _thumbnailPicArray;
@synthesize middlePicArray = _middlePicArray;
@synthesize photoTextArray = _photoTextArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.navigationItem.title = @"详情页面";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imageListBgView.png"]];
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, 60, 30);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_bar_item_bg.png"] forState:UIControlStateNormal];
    [leftButton setTitle:@"  返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftButton addTarget:self action:@selector(onReturn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    middlePicArray = [[NSMutableArray alloc]init];
    middlePicArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"middlePicArray"];
    photoTextArray = [[NSMutableArray alloc] init];
    photoTextArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"photoTextArray"];
    NSLog(@"middleArray = %@",middlePicArray);
    

}

- (void)onReturn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *urlString = [middlePicArray objectAtIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"cellTag"]-100];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"我拿到了 %@",url);
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *backgroundImage = [UIImage imageWithData:data];
	//UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
    CGRect backgroundRect = CGRectMake(0, 0, self.view.frame.size.width, backgroundImage.size.height);
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:backgroundRect];
    backgroundImageView.image = backgroundImage;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    CGRect textRect = CGRectMake(0, 0, self.view.frame.size.width, 400.0f);
    UITextView *textView = [[UITextView alloc] initWithFrame:textRect];
    NSString *text = [photoTextArray objectAtIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"cellTag"]-100];
    textView.text = text;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont systemFontOfSize:14.0f];
    textView.textColor = [UIColor darkTextColor];
    textView.editable = NO;
    
    MDCParallaxView *parallaxView = [[MDCParallaxView alloc] initWithBackgroundView:backgroundImageView
                                                                     foregroundView:textView];
    parallaxView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    parallaxView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    parallaxView.backgroundHeight = 250.0f;
    parallaxView.scrollViewDelegate = self;
    [self.view addSubview:parallaxView];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate Protocol Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%@:%@", [self class], NSStringFromSelector(_cmd));
}

@end
